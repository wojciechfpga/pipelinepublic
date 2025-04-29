#!/bin/bash

# Zmień źródło zegara (jeśli możliwe)
if [ -f /sys/devices/system/clocksource/clocksource0/available_clocksource ]; then
  if grep -q tsc /sys/devices/system/clocksource/clocksource0/available_clocksource; then
    echo "tsc" > /sys/devices/system/clocksource/clocksource0/current_clocksource 2>/dev/null
  fi
fi

# Ustaw transparent hugepages na madvise
if [ -f /sys/kernel/mm/transparent_hugepage/enabled ]; then
  echo madvise > /sys/kernel/mm/transparent_hugepage/enabled 2>/dev/null
fi

# Włącz delay accounting
if [ -f /proc/sys/kernel/task_delayacct ]; then
  echo 1 > /proc/sys/kernel/task_delayacct 2>/dev/null
fi

# Uruchom właściwą usługę / aplikację na końcu
exec "$@"
