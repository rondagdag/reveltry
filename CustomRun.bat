@echo off
CD d:\home\site\wwwroot
d:\home\site\wwwroot\azureapp\azureapp.exe -importPath azureapp -srcPath D:\home\site\wwwroot\azureapp\src -runMode prod -port %HTTP_PLATFORM_PORT%
