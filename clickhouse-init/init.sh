#!/bin/bash
set -e

echo ">>> Tylko podgląd ustawień systemowych (nie można ich zmienić na Docker/Windows)"

echo "Transparent HugePages:"
cat /sys/kernel/mm/transparent_hugepage/enabled 2>/dev/null || echo "niedostępne"

echo "Delay accounting:"
cat /proc/sys/kernel/task_delayacct 2>/dev/null || echo "niedostępne"

echo "Clocksource:"
cat /sys/devices/system/clocksource/clocksource0/current_clocksource 2>/dev/null || echo "niedostępne"

echo ">>> Uruchamianie ClickHouse..."
exec /entrypoint.sh
