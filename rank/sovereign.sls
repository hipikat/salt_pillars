#
# Pillar data the 'sovereign' box,
# primary controller for the cluster.
########################################

include:
  # Run primary private DNS and forwarding for the cluster
  - nameserver.primary

  # Install Irssi and open firewall ports for the bouncer
  - irc


empire:
  rank: sovereign
