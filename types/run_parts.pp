type Cron::Run_parts = Hash[
  Cron::Jobname,
  Struct[{
    NotUndef['user']       => Cron::User,
    Optional['minute']     => Cron::Minute,
    Optional['hour']       => Cron::Hour,
    Optional['dayofmonth'] => Cron::Date,
    Optional['month']      => Cron::Month,
    Optional['dayofweek']  => Cron::Weekday,
  }]
]
