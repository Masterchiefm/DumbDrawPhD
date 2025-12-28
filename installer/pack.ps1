conda activate py39
cd ..
pip uninstall DumbDrawPhD -y
pip install .
conda env list
cd installer
Remove-Item DumbDrawPhD_env.tar.gz -Recurse -Force
conda pack -n py39 -o DumbDrawPhD_env.tar.gz --ignore-missing-files
Remove-Item  DumbDrawPhD_Setup.exe -Recurse -Force
& "C:\Program Files (x86)\NSIS\makensis.exe" install.nsi
Remove-Item DumbDrawPhD_env.tar.gz -Recurse -Force

