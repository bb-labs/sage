function run() {
    const ws = Application("Xcode").activeWorkspaceDocument();

    ws.runDestinations().forEach(function (runDest) {
        if (runDest.platform() != "iphoneos" || runDest.name().includes("Any"))
            return;

        ws.activeRunDestination = runDest;
        const buildResult = ws.run();

        while (true) {
            if (buildResult.buildLog() &&
                buildResult.buildLog().endsWith("Build succeeded\n"))
                break;
        }
    });
}