/**
 * NASCENTIA - Système de détection de nouvelle version
 *
 * Vérifie automatiquement si une nouvelle version est disponible
 * et propose à l'utilisateur de rafraîchir la page
 */

(function () {
    'use strict';

    // Configuration
    const CHECK_INTERVAL = 5 * 60 * 1000; // Vérifier toutes les 5 minutes
    const VERSION_FILE = '/version.json';
    let currentVersion = null;
    let checkTimer = null;

    /**
     * Charge la version actuelle au démarrage
     */
    async function loadCurrentVersion() {
        try {
            const response = await fetch(VERSION_FILE + '?t=' + Date.now(), {
                cache: 'no-cache',
                headers: {
                    'Cache-Control': 'no-cache, no-store, must-revalidate',
                    'Pragma': 'no-cache'
                }
            });

            if (!response.ok) {
                console.warn('Version check: Could not load version.json');
                return null;
            }

            const data = await response.json();
            currentVersion = {
                version: data.version || '1.0.0',
                buildNumber: data.build_number || '1',
                hash: data.build_hash || ''
            };

            console.log('✅ Version actuelle:', currentVersion);
            return currentVersion;
        } catch (e) {
            console.warn('Version check error:', e);
            return null;
        }
    }

    /**
     * Vérifie si une nouvelle version est disponible
     */
    async function checkForUpdate() {
        if (!currentVersion) {
            console.warn('Version check: Current version not loaded');
            return false;
        }

        try {
            const response = await fetch(VERSION_FILE + '?t=' + Date.now(), {
                cache: 'no-cache',
                headers: {
                    'Cache-Control': 'no-cache, no-store, must-revalidate',
                    'Pragma': 'no-cache'
                }
            });

            if (!response.ok) {
                return false;
            }

            const data = await response.json();
            const newVersion = {
                version: data.version || '1.0.0',
                buildNumber: data.build_number || '1',
                hash: data.build_hash || ''
            };

            // Comparer les versions
            const isNewVersion =
                newVersion.version !== currentVersion.version ||
                newVersion.buildNumber !== currentVersion.buildNumber ||
                (newVersion.hash && newVersion.hash !== currentVersion.hash);

            if (isNewVersion) {
                console.log('🆕 Nouvelle version détectée:', newVersion);
                showUpdateNotification(currentVersion, newVersion);
                return true;
            }

            return false;
        } catch (e) {
            console.warn('Update check error:', e);
            return false;
        }
    }

    /**
     * Affiche une notification pour proposer la mise à jour
     */
    function showUpdateNotification(oldVersion, newVersion) {
        // Arrêter les vérifications futures
        if (checkTimer) {
            clearInterval(checkTimer);
            checkTimer = null;
        }

        // Créer la notification
        const notification = document.createElement('div');
        notification.id = 'update-notification';
        notification.innerHTML = `
      <div style="
        position: fixed;
        top: 20px;
        right: 20px;
        background: linear-gradient(135deg, #E95263 0%, #582674 100%);
        color: white;
        padding: 20px 24px;
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        z-index: 999999;
        max-width: 380px;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        animation: slideInRight 0.4s ease-out;
      ">
        <div style="display: flex; align-items: start; gap: 12px;">
          <div style="
            font-size: 28px;
            line-height: 1;
            flex-shrink: 0;
          ">🚀</div>
          <div style="flex: 1;">
            <div style="
              font-weight: 700;
              font-size: 16px;
              margin-bottom: 8px;
            ">Nouvelle version disponible !</div>
            <div style="
              font-size: 13px;
              opacity: 0.95;
              margin-bottom: 14px;
              line-height: 1.5;
            ">
              Une mise à jour est disponible. Rafraîchissez la page pour profiter des dernières améliorations.
            </div>
            <button onclick="window.location.reload(true)" style="
              background: white;
              color: #582674;
              border: none;
              border-radius: 8px;
              padding: 10px 20px;
              font-weight: 600;
              font-size: 14px;
              cursor: pointer;
              width: 100%;
              transition: transform 0.2s;
            " onmouseover="this.style.transform='scale(1.02)'" onmouseout="this.style.transform='scale(1)'">
              Mettre à jour maintenant
            </button>
            <button onclick="document.getElementById('update-notification').remove()" style="
              background: transparent;
              color: white;
              border: 1px solid rgba(255,255,255,0.3);
              border-radius: 8px;
              padding: 8px 16px;
              font-size: 13px;
              cursor: pointer;
              width: 100%;
              margin-top: 8px;
              transition: background 0.2s;
            " onmouseover="this.style.background='rgba(255,255,255,0.1)'" onmouseout="this.style.background='transparent'">
              Plus tard
            </button>
          </div>
        </div>
      </div>
      <style>
        @keyframes slideInRight {
          from {
            transform: translateX(400px);
            opacity: 0;
          }
          to {
            transform: translateX(0);
            opacity: 1;
          }
        }
      </style>
    `;

        document.body.appendChild(notification);

        // Auto-refresh après 30 secondes si aucune action
        setTimeout(() => {
            if (document.getElementById('update-notification')) {
                console.log('Auto-refresh: Mise à jour automatique après 30s');
                window.location.reload(true);
            }
        }, 30000);
    }

    /**
     * Démarre le système de vérification
     */
    async function init() {
        // Charger la version actuelle
        await loadCurrentVersion();

        // Vérifier immédiatement après 30 secondes
        setTimeout(checkForUpdate, 30000);

        // Puis vérifier périodiquement
        checkTimer = setInterval(checkForUpdate, CHECK_INTERVAL);

        // Vérifier lors du focus de la page
        window.addEventListener('focus', () => {
            setTimeout(checkForUpdate, 1000);
        });

        // Vérifier lors de la visibilité de la page
        document.addEventListener('visibilitychange', () => {
            if (!document.hidden) {
                setTimeout(checkForUpdate, 1000);
            }
        });

        console.log('✅ Version checker initialisé (intervalle: ' + (CHECK_INTERVAL / 60000) + ' min)');
    }

    // Démarrer au chargement de la page
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
