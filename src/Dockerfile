FROM sigven/pcgr:0.6.0

# Add local PCGR Python scripts/libraries
ADD pcgr_predispose.tgz /
ENV PATH=$PATH:/pcgr_predispose

USER root
WORKDIR /
ADD pcgr_predispose.R /

