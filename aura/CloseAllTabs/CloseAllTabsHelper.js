({
    tryInit: function(component, attempt) {
        var helperRef = this;
        var workspaceAPI = component.find("workspaceAPI");
        var max = component.get("v.maxRetries");
        var interval = component.get("v.retryIntervalMs");

        // If workspaceAPI not ready, retry up to max attempts
        if (!workspaceAPI || typeof workspaceAPI.getAllTabInfo !== 'function') {
            console.warn('Workspace API not ready. Attempt #' + attempt);
            if (attempt < max) {
                window.setTimeout($A.getCallback(function(){
                    helperRef.tryInit(component, attempt + 1);
                }), interval);
            } else {
                console.error('Workspace API unavailable after ' + max + ' retries. Make sure component is in a Console app (Utility Bar is recommended).');
            }
            return;
        }

        // Ask user confirmation (native confirm is simple and reliable)
        try {
            var msg = "Do you want to close all unpinned tabs?";
            if (window.confirm(msg)) {
                helperRef.closeUnpinnedTabs(component, workspaceAPI);
            } else {
                console.log('User cancelled closing tabs.');
            }
        } catch (e) {
            // In rare Locker contexts alert/confirm might be blocked — fallback to console log
            console.error('Confirm dialog failed: ', e);
        }
    },

    closeUnpinnedTabs: function(component, workspaceAPI) {
        workspaceAPI.getAllTabInfo().then($A.getCallback(function(tabs) {
            console.log('getAllTabInfo returned', tabs);

            if (!tabs || tabs.length === 0) {
                console.log('No tabs to close.');
                return;
            }

            // Close each unpinned tab (fire async close for each)
            tabs.forEach(function(tab) {
                // tab.pinned can be boolean; treat undefined as false (close)
                if (!tab.pinned) {
                    workspaceAPI.closeTab({ tabId: tab.tabId })
                        .then(function() {
                            console.log('Closed tab', tab.tabId);
                        })
                        .catch(function(err) {
                            console.error('Error closing tab ' + tab.tabId + ':', err);
                        });
                } else {
                    console.log('Skipped pinned tab', tab.tabId);
                }
            });
        })).catch($A.getCallback(function(error) {
            console.error('getAllTabInfo failed:', error);
        }));
    }
})