# Valid $special parameter to Cron::Job.
type Cron::Special = Optional[
  Enum['@annually',
       '@daily',
       '@hourly',
       '@midnight',
       '@monthly',
       '@weekly',
       '@yearly',
       '@startup',
       '@reboot',
  ]
]
