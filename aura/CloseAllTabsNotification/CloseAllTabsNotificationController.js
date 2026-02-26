({
	Yes : function(component, event, helper) {
        var workspaceAPI = component.find("workspaceAPI");
        if (workspaceAPI && workspaceAPI.getAllTabInfo) {
            workspaceAPI.getAllTabInfo().then(function(tabs) {
                tabs.forEach(function(tab) {
                    if (!tab.pinned) {
                        workspaceAPI.closeTab({ tabId: tab.tabId })
                        .catch(function(err) {
                            console.error("Error closing tab:", err);
                        });
                    }
                });
            }).catch(function(error) {
                console.error("Error fetching tabs:", error);
            });
        }
    },
    No : function(component, event, helper) {
        
    }
})