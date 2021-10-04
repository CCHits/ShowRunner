FROM ubuntu:14.04
ADD install_packages.sh /tmp/install_packages.sh
RUN chmod 700 /tmp/install_packages.sh && /tmp/install_packages.sh
ADD . /vagrant
RUN chmod 700 /vagrant/*.sh && /vagrant/run_setup.sh
ENTRYPOINT ["/bin/bash", "/vagrant/run_showmaker.sh"]
