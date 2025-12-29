conda activate py39
cd ..
pip uninstall DumbyDraw -y
pip install .
conda env list
cd installer
Remove-Item DumbyDraw_env.tar.gz -Recurse -Force
conda pack -n py39 -o DumbyDraw_env.tar.gz --ignore-missing-files
Remove-Item  DumbyDraw_Setup.exe -Recurse -Force
& "C:\Program Files (x86)\NSIS\makensis.exe" install.nsi
Remove-Item DumbyDraw_env.tar.gz -Recurse -Force

