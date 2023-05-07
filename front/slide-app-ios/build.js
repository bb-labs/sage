function run() {
    const ws = Application("Xcode").activeWorkspaceDocument();

    ws.runDestinations().forEach(function (runDest) {
        if (runDest.platform() != "iphoneos")
            return;

        ws.activeRunDestination = runDest;
        ws.run();

        delay(2)
    });
}