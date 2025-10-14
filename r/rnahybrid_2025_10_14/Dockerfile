# Use the official RNAhybrid biocontainer from Quay.io
# This provides a fully tested RNAhybrid installation with all dependencies
# Version 2.1.2 with the latest build from December 2024
FROM quay.io/biocontainers/rnahybrid:2.1.2--h7b50bb2_4

# Set working directory
WORKDIR /workspace

# The biocontainer already includes RNAhybrid and all dependencies
# RNAhybrid is available in the PATH

# Default command, used for verification
CMD ["RNAhybrid", "-h"]
