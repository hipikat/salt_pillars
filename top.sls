#
# Minion pillar configuration
####################################################

base:
  'hog':
    - profiles.monarch
    - users.hipikat


  # Monarchs are the highest-level masters
  'hrm-*':
    - profiles.monarch
    - users.hipikat

  #'hrm-kerry':
  #'mr-bones':
  #  - settings.reigning_monarch
  
  # Syndicated masters
  #'mx-*':
  #  - profiles.syndic_master


  #'hrm-piggy':
  #  - projects.uwaforward


  ### Deprecated ........

  # My 'peak' masters. Utility box, IRC proxy, and deployer of other masters.
  'mr-*':
    - profiles.emperor
    - groups.hipikat
    # Merge generic Shoaler formations into the pillar['shoaler'] dict
    - formations

  #'mr-(koala|bobtail)':
  #  - match: pcre
  #'mr-koala':
  #  - profiles.monarch
  #  - saltlick.salt_dev

  ####
  # Development
  ####

  # Personal development box, open to anyone in my office.
  'cory':
    - groups.perthfurs
    - profiles.cory

  ####
  # Blueprints for snapshots
  ####

  # 'Dormant' boxes with everything I usually need already installed.
  # Made to be turned into snapshots, which are in turn used to rapidly
  # deploy and configure nodes in any cloud formation. Suffix is of the
  # form '-512M', '-1G', '-2G', etc.
  '*-stem-*':
    - groups.hipikat

  # More development tools
  'dev-stem-*':
    - profiles.dev-stem

  # More security out-of-the-box
  'prod-stem-*':
    - profiles.prod-stem

  ####
  # Ongoing projects
  ####

  # Production web host formation: [us|sng]-home-prod-[front|webN|db]
  # Created and scaled by Shoaler, projects managed by Chippery
  #'*-home-prod-*':
  #  - groups.hipikat
  #  - profiles.personal_web_prod

  # Nedsaver.org campaign website
  'nedsaver.org':
    - groups.hipikat
