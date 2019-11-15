#! /bin/bash

firmware_version="100AAJX8"
model_name="P8702N"
bi_this_dir=`pwd`
bi_src_base=$bi_this_dir
bi_crosstools_dir=/opt/toolchains/uclibc-crosstools-gcc-4.4.2-1


clear
echo ""
echo "This script installs $model_name DSL router components onto your Linux PC.  The"
echo "installation will overwrite existing files.  You will be prompted before a"
echo "component is installed."
echo ""
echo ""
echo ""
for f in *
do
    case $f in
    *_consumer.tar.gz)
        bi_src_dir=$bi_src_base/$firmware_version
        echo ""
        echo "The $model_name DSL router source files are ready to be installed at "
        echo "$bi_src_dir. Existing source files, in any, will be overwritten. "
        echo ""
        echo ""
        echo ""
        echo ""
        if ! [ -d $bi_src_dir ] ; then
            echo "Creating directory $bi_src_dir."
            echo ""
            mkdir -p $bi_src_dir
        fi
        if [ -d $bi_src_dir ] ; then
            echo "Installing files from $bi_this_dir/$f."
            echo ""
            cd $bi_src_dir
            tar xfz $bi_this_dir/$f
            chmod -R 777 * .*
            cd $bi_this_dir
        else
            echo "The directory $bi_src_dir does not exist."
            echo "The $model_name DSL router source files were not installed."
        fi
        echo ""
        ;;
    crosstools-mips*.tar.bz2)
        echo ""
        echo "The $model_name DSL router toolchain is ready to be installed at $bi_crosstools_dir."
        echo "Existing toolchain files, if any, will be overwritten."
        echo ""
        echo ""
        echo ""
        echo ""
        echo "Installing files from $bi_this_dir/$f."
        echo ""
        tar xPfj $bi_this_dir/$f
        echo ""
        ;;
    esac
done
