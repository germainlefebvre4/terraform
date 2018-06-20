#! /bin/sh
### BEGIN INIT INFO
# Provides:          agapes-demo
# Required-Start:    \$$network \$$syslog
# Required-Stop:     \$$network \$$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: agapes-demo
# Description:       agapes-demo
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin
NAME=agapes-demo
USER=dotnet
ROOT=/home/\$$USER/\$$NAME/
APP=agapes-demo.dll
DOTNET=/opt/dotnet/dotnet
PIDFILE=/var/run/\$$NAME/\$$NAME.pid
SCRIPTNAME=/etc/init.d/\$$NAME
LOGFILE=/var/log/\$$NAME/\$$NAME.log

if [ ! -d /var/run/\$$NAME ]; then
        mkdir /var/run/\$$NAME
        chown \$$USER:\$$USER /var/run/\$$NAME
fi
if [ ! -d /var/log/\$$NAME ]; then
        mkdir /var/log/\$$NAME
        chown \$$USER:\$$USER /var/log/\$$NAME
fi
cd \$$ROOT
. /etc/rc.d/init.d/functions

start()
{
        echo -n \"Starting \$$NAME...\"

        if [ -n \"`pidof \$$DOTNET`\" ];
        then
                echo -n \"already running...\"
                warning
                echo
                exit 0;
        fi
        cd \$$ROOT
        daemon --pidfile \"\$$PIDFILE\" --user \"\$$USER\" --check \$$NAME \"\$$DOTNET exec \$$APP >\$$LOGFILE 2>&1 &\";
        RETVAL=\$$?
        if [ \$$RETVAL -eq 0 ];
        then
                sleep 10
                PID=\$$(pidof \$$DOTNET)
#               echo \$$PID
                echo `pidof \$$DOTNET` > \$$PIDFILE
                echo `pgrep -P \$$PID` >> \$$PIDFILE

                touch /var/lock/subsys/\$$NAME && success || failure
                echo
        else
                rm -f \$$PIDFILE
                rm -f /var/lock/subsys/\$$NAME
                exit 7;
        fi
}

stop()
{

        if [ ! -f \"\$$PIDFILE\" ]; then
                #failure
                echo -n \"\$$NAME not running\"
                echo
                exit 0
#               failure
        fi
        echo -n \"Stopping \$$NAME...\"
        kill -9 \$$(cat \"\$$PIDFILE\")

        #[ -n \"`pidof \"\$$DOTNET\"`\" ] && kill \"`pidof \"\$$DOTNET\"`\" >/dev/null 2>&1

#        timeout=0
#        RETVAL=0
#        while `pidof -s \"\$$DOTNET\"` &>/dev/null;
#        do
#                       sleep 2 && echo -n \".\"
#                       timeout=\$$((timeout+2))
#        done

        # remove pid files
        if [ \$$RETVAL -eq 0 ];
        then
                rm -f /var/lock/subsys/\$$NAME
                rm -f \$$PIDFILE
        fi

        if [ \$$RETVAL -eq 0 ];
        then
#               echo \"\$$NAME stopped\"
                success
        else
#               echo \"\$$NAME failed\"
                failure
                RETVAL=1
        fi
        echo
}

restart ()
{
        stop
        start
}

status ()
{
 #       check_pidfile
         if [ -f \"\$$PIDFILE\" ] ;
        then
                echo -n \"\$$NAME is running...\"
                success
                echo
        else
                echo -n \"\$$NAME is not running...\"
                failure
                echo
        fi
        exit 0;
}

RETVAL=0

case \"\$$1\" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart|force-reload)
    restart
    ;;
  status)
    status
    ;;
  *)
    echo \"Usage: \$$0 {start|stop|status|restart|force-reload}\"
    RETVAL=1
esac

exit \$$RETVAL