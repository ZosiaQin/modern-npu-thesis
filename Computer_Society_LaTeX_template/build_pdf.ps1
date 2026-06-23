$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$tectonic = Join-Path $root "tools\tectonic\tectonic.exe"
$cache = Join-Path $root "tools\tectonic\cache"
$tex = "uav_csa_lshade_paper.tex"

if (-not (Test-Path -LiteralPath $tectonic)) {
  throw "Tectonic executable not found: $tectonic"
}

New-Item -ItemType Directory -Force -Path $cache | Out-Null
$env:TECTONIC_CACHE_DIR = $cache

Push-Location $PSScriptRoot
try {
  & $tectonic $tex --keep-logs --keep-intermediates
}
finally {
  Pop-Location
}
