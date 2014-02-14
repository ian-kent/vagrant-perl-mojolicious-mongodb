# Configure apt for mongodb
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# Update apt sources
apt-get update

# Install stuff available through apt-get
apt-get install -y curl unzip wget git vim mongodb-10gen build-essential

# Install cpanminus
curl -L http://cpanmin.us | perl - App::cpanminus

# Install Mojolicious and Mango
mkdir -p /opt/perlbrew/perl5
export PERLBREW_ROOT=/opt/perlbrew/perl5
cpanm App::perlbrew

# Install perl 5.18.2
perlbrew init
perlbrew install-cpanm
perlbrew install perl-5.18.2
chown root:vagrant /opt/perlbrew/perl5 -R
chmod -R g+w /opt/perlbrew/perl5

# Configure environment
echo 'export PERLBREW_ROOT=/opt/perlbrew/perl5' >> /etc/profile.d/perlbrew.sh
echo 'export PATH=/opt/perlbrew/perl5/bin:/opt/perlbrew/perl5/perls/perl-5.18.2/bin:$PATH' >> /etc/profile.d/perlbrew.sh
chmod +x /etc/profile.d/perlbrew.sh
. /etc/profile.d/perlbrew.sh
cpanm Mojolicious Mango
