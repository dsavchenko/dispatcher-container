FROM python:3.8

RUN pip install pip --upgrade

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD cdci_data_analysis /cdci_data_analysis
RUN pip install -r /cdci_data_analysis/requirements.txt && \
    pip install /cdci_data_analysis

ADD cdci_osa_plugin /cdci_osa_plugin
RUN pip install -r /cdci_osa_plugin/requirements.txt && \
    pip install /cdci_osa_plugin

ADD oda_api /oda_api
RUN pip install -r /oda_api/requirements.txt && \
    pip install /oda_api

RUN pip install 'git+https://github.com/integral-observatory/astroquery.git#egg=astroquery'

# these will be mounted at runtime
ENV CDCI_OSA_PLUGIN_CONF_FILE=/dispatcher/conf/conf.d/osa_data_server_conf.yml
ENV CDCI_POLAR_PLUGIN_CONF_FILE=/dispatcher/conf/conf.d/polar_data_server_conf.yml
ENV CDCI_MAGIC_PLUGIN_CONF_FILE=/dispatcher/conf/conf.d/magic_data_server_conf.yml

WORKDIR /data/dispatcher_scratch

ADD entrypoint.sh /dispatcher/entrypoint.sh
ENTRYPOINT bash /dispatcher/entrypoint.sh
