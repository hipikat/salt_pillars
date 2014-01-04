Adam Wright's SaltStack pillar configuration
============================================

My (still emerging) pillar configuration - currently, rather than using
Salt's notion of environments, minions are targetted in pillar SLS files.
This approach seems more amenable to the idea of multiple-projects or
instances of projects running on a single VM, which is what I'm experimenting
with formulas for at the moment. (VMs configurations are in droplets/, since
I'm using DigitalOcean as my test provider...)
