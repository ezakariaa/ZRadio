# 🎵 Z Radio

**Musique 24/7 – Hits & Classics**

Une application web de streaming radio avec lecteur audio HTML5 et affichage en temps réel des métadonnées musicales.

## ✨ Fonctionnalités

- 🎧 **Streaming audio en direct** via Icecast 2
- 🖼️ **Affichage automatique des pochettes d'album** récupérées depuis plusieurs sources (iTunes, Deezer, MusicBrainz, Last.fm)
- 📊 **Compteur d'auditeurs** en temps réel
- 🎵 **Affichage des métadonnées** (titre, artiste) de la piste actuelle
- 📜 **Historique des pistes précédentes** avec pochette d'album
- 🎨 **Interface moderne et responsive** avec animations
- ⚡ **Configuration optimisée** avec Caddy pour le reverse proxy et la gestion CORS

## 🛠️ Technologies utilisées

- **Frontend** : HTML5, CSS3, JavaScript vanilla
- **Streaming** : Icecast 2
- **Reverse Proxy** : Caddy
- **APIs externes** :
  - iTunes Search API (pour les pochettes)
  - Deezer API
  - MusicBrainz / Cover Art Archive
  - Last.fm API (optionnel)

## 📁 Structure du projet

```
ZRadio/
├── index.html          # Page principale du player
├── player.html         # Page alternative du player (si présente)
├── Caddyfile          # Configuration Caddy pour le reverse proxy
├── cover.gif          # Image par défaut de la pochette
├── cover.png          # Image de couverture alternative
├── intro.mp3          # Fichier d'introduction audio
└── README.md          # Ce fichier
```

## 🚀 Installation et déploiement

### Prérequis

- **Caddy** (serveur web/reverse proxy)
- **Icecast 2** (serveur de streaming)
- Un serveur hébergeant le flux audio sur `http://127.0.0.1:8000`

### Configuration Caddy

Le fichier `Caddyfile` est déjà configuré pour :
- Proxy reverse vers le serveur Icecast (port 8000)
- Gestion des en-têtes CORS pour les APIs
- Optimisation du streaming audio
- Cache pour les fichiers statiques

### Déploiement

1. Assurez-vous que votre serveur Icecast fonctionne sur `127.0.0.1:8000`
2. Configurez votre domaine dans `Caddyfile` (actuellement `z-radio.viewdns.net`)
3. Démarrez Caddy :
   ```bash
   caddy run
   ```

## 🎛️ Configuration

### Flux audio

Le flux audio est configuré dans `index.html` :
```javascript
const ICECAST_BASE = "https://z-radio.viewdns.net";
```

### Métadonnées

Les métadonnées sont récupérées depuis plusieurs sources dans cet ordre de priorité :
1. Fichier `Snip_Metadata.json` (serveur local)
2. API Icecast (`/status-json.xsl`)
3. Fichiers d'historique (`Snip_History.json`, `Snip_PlayHistory.json`, etc.)

### Pochettes d'album

Le système recherche automatiquement les pochettes d'album dans cet ordre :
1. **iTunes** (600x600px) - meilleure qualité
2. **Deezer** (1000x1000px) - très bonne qualité, API gratuite
3. **MusicBrainz + Cover Art Archive** (500x500px) - gratuit et open source
4. **Last.fm** (si clé API configurée)

Pour utiliser Last.fm, obtenez une clé API gratuite sur https://www.last.fm/api/account/create et modifiez la constante `apiKey` dans `index.html`.

## 🔧 Personnalisation

### Modifier les couleurs

Les couleurs principales sont définies dans les variables CSS :
```css
:root {
  --accent: #1db954;  /* Couleur d'accent (vert Spotify) */
  --bg1: #0e0e0e;     /* Fond principal */
  --bg2: #232526;     /* Fond secondaire */
}
```

### Changer l'image par défaut

Remplacez `cover.gif` ou modifiez la constante `FALLBACK_IMG` dans le JavaScript.

## 📝 Notes

- Le player détecte automatiquement si le serveur est en panne et affiche un message d'erreur approprié
- Les métadonnées sont mises à jour toutes les 2 secondes (Snip_Metadata) et 15 secondes (Icecast)
- Le système gère automatiquement la mise à jour des pochettes d'album lors des changements de piste

## 👤 Auteur

**Zakaria ELORCHE**

© 2025 Z Radio

## 📄 Licence

Ce projet est privé.

---

*Powered by Icecast 2*
