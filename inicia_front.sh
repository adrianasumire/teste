export PATH=/usr/bin:$PATH
export DOTNET_ROOT=/usr/share/dotnet/dotnet_5_0/
cp /usr/share/dotnet/dotnet_5_0/appsettings.json /app/backend-doai/DoaiApi/.
cd /app/backend-doai/DoaiApi
nohup dotnet run &

cd 