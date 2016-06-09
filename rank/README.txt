
Nodes are ranked with the following conventions:

- The 'sovereign' is at the top of the hierarchy. It acts as the
  main Salt controller and primary private network DNS controller.
  The sovereign includes all pillar data from the noble rank.

- A 'prefect' acts as the second main controller after a 'sovereign'.
  They are used as redundant Salt masters, secondary DNS controllers,
  and should incrementally replicate all new data on the sovereign.
  A prefect should take the role of sovereign if the sovereign dies.
  The prefect rank includes all pillar data from the noble rank.

- A 'noble' minion is still an upper-eschelon machine, with most of
  the software required for the 'sovereign' rank installed but 
  disabled. Any noble can be promoted to a higher rank. Noble minions
  Put the sovereign first, and fall back to prefects, in both the
  case of a Salt multi-master setup, and for internal DNS queries.

- Every other node is just a peasant.
