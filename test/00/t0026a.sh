#!/bin/sh
#
# UCSD p-System filesystem in user space
# Copyright (C) 2010 Peter Miller
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# you option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>
#

TEST_SUBJECT="ucsdpsys_disk vs no file"
. test_prelude

cat > test.ok << 'fubar'
ucsdpsys_disk: open(pathname = "ha-ha-ha", flags = O_RDONLY) failed, No
    such file or directory (2, ENOENT) because there is no "ha-ha-ha"
    regular file in the current directory
fubar
test $? -eq 0 || no_result

ucsdpsys_disk -f ha-ha-ha > test.out 2>&1
if test $? -ne 1
then
    cat test.out
    echo supposed to fail 1>&2
    fail
fi

diff test.ok test.out
test $? -eq 0 || fail

#
# The functionality exercised by this test worked.
# No other assertions are made.
#
pass
