FROM arm32v7/ruby:2.4

# Install packages
RUN apt-get update \
    && apt-get install -y build-essential libpq-dev nodejs \
    && apt-get clean

# Install Bundler
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem install bundler

RUN mkdir -p /var/app/code /var/app/profile.d /var/log/puma

ONBUILD COPY ["Gemfile", "Gemfile.lock", "/var/app/code/"]
ONBUILD RUN bundler install --jobs 4
# ONBUILD ADD . /var/app/code
# setup the environment and precompile the assets
ONBUILD ENV RAILS_ENV production
ONBUILD ENV SECRET_KEY_BASE $(openssl rand -base64 32)
# ONBUILD RUN rails assets:precompile
ONBUILD RUN echo "export RAILS_ENV=\"\${RAILS_ENV:-$RAILS_ENV}\" SECRET_KEY_BASE=\"\${SECRET_KEY_BASE:-$SECRET_KEY_BASE}\"" > /var/app/profile.d/50-ruby.sh

WORKDIR /var/app/code
ONBUILD VOLUME ["/var/app/code", "/var/log/puma"]

COPY init.sh /usr/bin/init.sh
RUN chmod +x /usr/bin/init.sh

CMD ["/usr/bin/init.sh"]
