#! /usr/bin/env python
import sys
import os
import datetime
import shutil


def error_deleting(function, dirpath, excinfo):
    print "Directory " + dirpath + " doesnt exist!"

def main():
    print "Sicily's Pizza old file remover."
    print "********************************\n"
    an_error_occurred = False
    script_path = os.path.dirname(os.path.realpath(__file__))
    print "Getting path to script: " + script_path + "/" + __file__
    try:
        os.chdir(script_path)
    except OSError:
        print "Problem changing to: " + script_path
        return 1
    print "Changing current working directory to script path..."
    current_working_dir = os.getcwd()
    #print os.listdir(current_working_dir)
    now = datetime.datetime.now()
    print "Current year is: " + str(now.year) + " traversing..."
    current_month = str(now.month) if now.month > 9 else "0"+str(now.month) # , now.month-2, now.day, now.hour, now.minute, now.second
    print "Current month is: " + current_month
    
    del_dir = "00"
    if now.month > 1:
        del_dir = str(now.month-1) if now.month-1 > 9 else "0"+str(now.month-1)
        try:
            os.chdir("./" + str(now.year))
        except OSError:
            print "Problem changing to: " + "./" + str(now.year)
            return 1
        current_working_dir = os.getcwd()
        print "Current directory path: " + current_working_dir
        print "Directory listing: " + str(os.listdir(current_working_dir))
        print "\nDeleting directories older than: " + del_dir + " ... "
        for x in xrange(1, now.month - 1):
            del_dir = "0" + str(x) if x < 10 else str(x)
            try:
                shutil.rmtree(current_working_dir + "/" + del_dir)
                print "Deleting dir: " + current_working_dir + "/" + del_dir + " ... [OK]" 
            except OSError:
                print "Deleting dir: " + current_working_dir + "/" + del_dir + " ... [NOT_EXIST]"
        print "Done."
    else:
        # TOOD: Check last year
        print "Nothing to delete!"
        return 0
    
    # Otherwise 0, success is returned.
    return 0

# This is true if the script is run by the interpreter, not imported by another
# module.
if __name__ == '__main__':
    # main should return 0 for success, something else (usually 1) for error.
    sys.exit(main())