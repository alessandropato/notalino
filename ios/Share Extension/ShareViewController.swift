import receive_sharing_intent

/// Riceve i file condivisi (audio, memo vocali, file) e reindirizza subito a
/// Notalino: nessuna UI di composizione, comportamento di default della
/// libreria (`shouldAutoRedirect() == true`).
class ShareViewController: RSIShareViewController {
}
