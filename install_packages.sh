#!/bin/bash
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y festival \
                    festlex-cmu \
                    festlex-poslex \
                    festlex-oald \
                    libestools1.2 \
                    unzip \
                    mp4v2-utils \
                    vorbis-tools \
                    eyed3 \
                    git \
                    sox \
                    libsox-fmt-all \
                    libav-tools \
                    php5-cli \
                    php5-curl \
                    curl \
                    sendemail \
                    libio-socket-ssl-perl \
                    libnet-ssleay-perl \
                    sshpass \
                    wget

if grep -e '^mozilla/DST_Root_CA_X3.crt' /etc/ca-certificates.conf
then
  sudo sed -i -e 's=^mozilla/DST_Root_CA_X3.crt=!mozilla/DST_ROOT_CA_X3.crt=' /etc/ca-certificates.conf && sudo update-ca-certificates -f
fi

if [ ! -d /usr/share/festival/voices/english/cmu_us_clb_arctic_clunits ] ; then
  rm -Rf /var/cmu_voices
  mkdir /var/cmu_voices
  cd /var/cmu_voices
  wget -q -t0 http://www.speech.cs.cmu.edu/cmu_arctic/packed/cmu_us_clb_arctic-0.95-release.tar.bz2
  tar xf cmu_us_clb_arctic-0.95-release.tar.bz2
  rm *.bz2
  sudo mkdir -p /usr/share/festival/voices/english
  sudo mv * /usr/share/festival/voices/english/
  sudo mv "/usr/share/festival/voices/english/cmu_us_clb_arctic" "/usr/share/festival/voices/english/cmu_us_clb_arctic_clunits"
  cd /var
  rm -Rf /var/cmu_voices
fi
