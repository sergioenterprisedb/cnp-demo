FROM ghcr.io/cloudnative-pg/postgresql:14.3

# To install any package we need to be root
USER root

# We update the package list, install our package
# and clean up any cache from the package manager
RUN set -xe; \
	apt-get update; \
        #apt-get install -y language-pack-fr; \
        apt-get install -y locales locales-all htop procps; \
	rm -fr /tmp/* ; \
	rm -rf /var/lib/apt/lists/*;

# Change to the uid of postgres (26)
USER 26

