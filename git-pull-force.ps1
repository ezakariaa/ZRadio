# Script PowerShell pour forcer un git pull de maniere robuste
# Sauvegarde les modifications locales et force la synchronisation avec origin/master

Write-Host "=== Git Pull Renforce ===" -ForegroundColor Cyan

# Verifier si on est dans un depot git
if (-not (Test-Path .git)) {
    Write-Host "Erreur: Ce n'est pas un depot git!" -ForegroundColor Red
    exit 1
}

# Afficher l'etat actuel
Write-Host "`nEtat actuel:" -ForegroundColor Yellow
git status --short

# Sauvegarder les modifications locales
$hasChanges = git diff --quiet; $exitCode = $LASTEXITCODE
$hasStaged = git diff --cached --quiet; $stagedExitCode = $LASTEXITCODE

if ($exitCode -ne 0 -or $stagedExitCode -ne 0) {
    Write-Host "`nSauvegarde des modifications locales..." -ForegroundColor Yellow
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    git stash push -m "Auto-sauvegarde avant pull force - $timestamp"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Modifications sauvegardees dans le stash" -ForegroundColor Green
    }
}

# Recuperer les dernieres modifications
Write-Host "`nRecuperation des modifications distantes..." -ForegroundColor Yellow
git fetch origin
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors du fetch!" -ForegroundColor Red
    exit 1
}

# Forcer la synchronisation
Write-Host "`nSynchronisation forcee avec origin/master..." -ForegroundColor Yellow
git reset --hard origin/master
if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Synchronisation reussie!" -ForegroundColor Green
} else {
    Write-Host "Erreur lors de la synchronisation!" -ForegroundColor Red
    exit 1
}

# Nettoyer les references obsoletes
Write-Host "`nNettoyage des references..." -ForegroundColor Yellow
git fetch --prune

# Afficher le resultat final
Write-Host "`n=== Resultat final ===" -ForegroundColor Cyan
git status
Write-Host "`nDerniers commits:" -ForegroundColor Yellow
git log --oneline -5

Write-Host "`n[OK] Pull renforce termine avec succes!" -ForegroundColor Green
Write-Host "Note: Vos modifications locales sont sauvegardees dans le stash." -ForegroundColor Gray
Write-Host "Pour les recuperer: git stash pop" -ForegroundColor Gray
