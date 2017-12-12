#!/bin/sh

export DISPLAY=:0

connectedPorts=$(xrandr | grep " connected" | sed 's/ connected.*//')
for port in $connectedPorts ; do
    xrandr --output $port --auto
done

disconnectedPorts=$(xrandr | grep " disconnected" | sed 's/ disconnected.*//')
for port in $disconnectedPorts ; do
    xrandr --output $port --off
done

