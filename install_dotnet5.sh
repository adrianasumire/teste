cd /usr/share/dotnet/dotnet_5_0
tar -zxvf dotnet-sdk-5.0.408-linux-x64.tar.gz
rm /usr/share/dotnet/dotnet
rm /usr/bin/dotnet
ln -s /usr/share/dotnet/dotnet_5_0/dotnet /usr/share/dotnet/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
