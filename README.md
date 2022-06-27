# Current nvim setup

## Non obvious dependencies

Some tools that are useful but not explicitly required:

* `shellcheck`
* `lua-language-server`
* `mupdf`

Otherwise consider running `:checkhealth` to check for other missing executables.

## Language servers

Ensure language servers that are in use in `lsp-installer.lua` are installed. Language servers can be installed using `:LspInstallInfo`

## Java dependencies

nvim-jdtls is extended with third party repositories

### `java-debug`

```
git clone git@github.com:microsoft/java-debug.github
cd java-debug
./mvnw clean install
```

### `vscode-java-test`

Extension has telemetry enabled by default. If you opt out to send telemetry data to Microsoft, please set below configuration in settings.json: `telemetry.enableTelemetry = false`

```
git clone git@github.com:microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
```

## `null-ls`

Tools used for additional diagnostics and formatting. The ones that are defined in the current setup are:

* `prettier`
* `black`
* `stylua`
* `google_java_format`
* `flake8`

These all need to be manually installed and on `PATH`. They can also be removed by editing `null-ls.lua` ( original formatting can be re-enabled in `handlers.lua` )
