@echo off
MSBuild /nologo liblua.sln /maxCpuCount:2 /Target:Build /Property:Configuration=Debug /Property:Platform=Win32
MSBuild /nologo liblua.sln /maxCpuCount:2 /Target:Build /Property:Configuration=Debug /Property:Platform=x64
MSBuild /nologo liblua.sln /maxCpuCount:2 /Target:Build /Property:Configuration=Release /Property:Platform=Win32
MSBuild /nologo liblua.sln /maxCpuCount:2 /Target:Build /Property:Configuration=Release /Property:Platform=x64
