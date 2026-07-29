#!/usr/bin/env ruby
# Aggiunge il target "Share Extension" al progetto Xcode di Notalino.
# Script una tantum: idempotente solo per la parte di verifica iniziale
# (fallisce esplicitamente se il target esiste già, per evitare doppioni).
require 'xcodeproj'

PROJECT_PATH = 'ios/Runner.xcodeproj'
TEAM_ID = '9B7Y6A3WNL'
BUNDLE_ID = 'it.maketron.notalino.ShareExtension'
DEPLOYMENT_TARGET = '14.0'

project = Xcodeproj::Project.open(PROJECT_PATH)

if project.targets.any? { |t| t.name == 'Share Extension' }
  abort 'Il target "Share Extension" esiste già: interrompo per non duplicare.'
end

runner_target = project.targets.find { |t| t.name == 'Runner' }
abort 'Target Runner non trovato' unless runner_target

# --- Trova il product dependency del package Flutter già linkato a Runner ---
flutter_pkg_dep = runner_target.package_product_dependencies.find { |d| d.product_name == 'FlutterGeneratedPluginSwiftPackage' }
abort 'FlutterGeneratedPluginSwiftPackage non trovato su Runner' unless flutter_pkg_dep

# --- Nuovo target: Share Extension (app extension) ---
share_target = project.new_target(:app_extension, 'Share Extension', :ios, DEPLOYMENT_TARGET, project.main_group, :swift)

# --- Gruppo + file reference per i file della extension ---
# Il gruppo ha già path 'Share Extension': i riferimenti sono relativi ad esso
# (solo nome file, altrimenti il path raddoppia: "Share Extension/Share Extension/...").
group = project.main_group.new_group('Share Extension', 'Share Extension')
info_plist_ref = group.new_reference('Info.plist')
swift_ref = group.new_reference('ShareViewController.swift')
entitlements_ref = group.new_reference('Share Extension.entitlements')

share_target.source_build_phase.add_file_reference(swift_ref)

# --- Build settings per Debug/Release/Profile ---
share_target.build_configurations.each do |config|
  settings = config.build_settings
  settings['PRODUCT_NAME'] = 'Share Extension'
  settings['PRODUCT_BUNDLE_IDENTIFIER'] = BUNDLE_ID
  settings['INFOPLIST_FILE'] = 'Share Extension/Info.plist'
  settings['CODE_SIGN_ENTITLEMENTS'] = 'Share Extension/Share Extension.entitlements'
  settings['CODE_SIGN_STYLE'] = 'Automatic'
  settings['DEVELOPMENT_TEAM'] = TEAM_ID
  settings['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
  settings['SWIFT_VERSION'] = '5.0'
  settings['TARGETED_DEVICE_FAMILY'] = '1,2'
  settings['MARKETING_VERSION'] = '1.0'
  settings['CURRENT_PROJECT_VERSION'] = '1'
  settings['GENERATE_INFOPLIST_FILE'] = 'NO'
  settings['SKIP_INSTALL'] = 'YES'
  settings['LD_RUNPATH_SEARCH_PATHS'] = ['$(inherited)', '@executable_path/Frameworks', '@executable_path/../../Frameworks']
  settings['SWIFT_EMIT_LOC_STRINGS'] = 'NO'
  settings['CODE_SIGN_IDENTITY'] = 'Apple Development'
end

# --- Link dello stesso package Flutter (fornisce receive_sharing_intent) ---
share_target.package_product_dependencies << flutter_pkg_dep
pkg_build_file = project.new(Xcodeproj::Project::Object::PBXBuildFile)
pkg_build_file.product_ref = flutter_pkg_dep
share_target.frameworks_build_phase.files << pkg_build_file

# --- Runner dipende dalla build della extension ---
runner_target.add_dependency(share_target)

# --- Embed Foundation Extensions (prima di "Thin Binary") ---
embed_phase = runner_target.new_copy_files_build_phase('Embed Foundation Extensions')
embed_phase.symbol_dst_subfolder_spec = :plug_ins
embed_build_file = project.new(Xcodeproj::Project::Object::PBXBuildFile)
embed_build_file.file_ref = share_target.product_reference
embed_build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }
embed_phase.files << embed_build_file

thin_binary_index = runner_target.build_phases.find_index { |p| p.respond_to?(:name) && p.name == 'Thin Binary' }
if thin_binary_index
  runner_target.build_phases.delete(embed_phase)
  runner_target.build_phases.insert(thin_binary_index, embed_phase)
end

# --- Entitlements su Runner (App Group) ---
runner_target.build_configurations.each do |config|
  config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'Runner/Runner.entitlements'
end

project.save

puts 'OK: target "Share Extension" creato e collegato a Runner.'
