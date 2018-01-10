type Cron::Run_parts = Hash[
  String,
  Struct[{
    NotUndef['user']       => String,
    Optional['minute']     => String,
    Optional['hour']       => String,
    Optional['dayofmonth'] => String,
    Optional['month']      => String,
    Optional['dayofweek']  => String,
  }]
]
