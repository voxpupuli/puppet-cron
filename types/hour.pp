# Valid $hour parameter to Cron::Job.
type Cron::Hour = Variant[
  Integer[0,23],
  Pattern[/\A(([0-9]|1[0-9]|2[0-3])|(\*|(([0-9]|1[0-9]|2[0-3])-([0-9]|1[0-9]|2[0-3])))(\/([1-9]|1[0-9]|2[0-3]))?)\z/]
]
