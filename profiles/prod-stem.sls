#
# A dormant minion ready for rapid repurposing into any configuration
########################################################################


# Use Chippery to manage and configure projects across syndicated machines
chippery:

  # Enable minion-targetting via 'chippery:enabled:True' (when you also
  # pass it a '- match: pillar' option) in the Top states file.
  enabled: True

  stacks:
    - multi-tool
