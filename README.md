# Current nvim setup

Largely based on

## Language servers

Ensure language servers that are in use in `lsp-installer.lua` are installed. Language servers can be installed using `:LspInstallInfo`

## Java dependencies

nvim-jdtls is extended with third party repositories

### java-debug

```
git clone git@github.com:microsoft/java-debug.github
cd java-debug
./mvnw clean install
```

### vscode-java-test

Extension has telemetry enabled by default. If you opt out to send telemetry data to Microsoft, please set below configuration in settings.json: `telemetry.enableTelemetry = false`

```
git clone git@github.com:microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
```

### google-java-format

Google style formatting for java, this has to be manually installed. jdtls can be used instead for standard formatting, if that is preferable then google-java-format should be removed from `null-ls.lua` and jdtls document formatting capabilities should be re-enabled in the if statement block in `handlers.lua`.
