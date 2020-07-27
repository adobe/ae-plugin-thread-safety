#!/bin/bash
# Copyright 2020 Adobe
# All Rights Reserved.

# NOTICE: Adobe permits you to use, modify, and distribute this file in
# accordance with the terms of the Adobe license agreement accompanying
# it. If you have received this file from a source other than Adobe,
# then your use, modification, or distribution of it requires the prior
# written permission of Adobe.

nm -demangle -print-file-name "$1" |\
	grep -o [[:space:]][B,D,b,d,S,s,u,V,v,W,w][[:space:]].* |\
	sed -e 's/^[ \t]*//' |\
	sed 's/ /; /' |\
	uniq |\
	grep -v "sDisabled" |\
	grep -v "sEnabled" |\
	grep -v "sTraceChangeCount" |\
	grep -v "in_place_init" |\
	grep -v "BIB_T_MT" |\
	grep -v "_G_zhdr" |\
	grep -v "_G_zref" |\
	grep -v "_G_ztab" |\
	grep -v "typeinfo name for" |\
	grep -v "typeinfo for"|\
	grep -v "GCC_except_table" |\
	grep -v "dyld" |\
	grep -v "g_strs" |\
	grep -v "AEFX_DEBUG_draw_bounding_boxB" |\
	grep -v "VideoFrameASLClassID" |\
	grep -v "AdobeOR709_colorSpaceID" |\
	grep -v "AdobeOR2020_colorSpaceID" |\
	grep -v "AdobeOR2100PQ_colorSpaceID" |\
	grep -v "AdobeOR2100HLG_colorSpaceID" |\
	grep -v "AdobeOR2020Linear_colorSpaceID" |\
	grep -v "boost::none" |\
	grep -v "typeinfo for boost::property_tree::ptree_error" |\
	grep -v "typeinfo for boost::property_tree::ptree_bad_data" |\
	grep -v "typeinfo for boost::property_tree::ptree_bad_path" |\
	grep -v "typeinfo for boost::system::system_error" |\
	grep -v "typeinfo for boost::system::error_category::std_category" |\
	grep -v "typeinfo name for boost::property_tree::ptree_error" |\
	grep -v "typeinfo name for boost::property_tree::ptree_bad_data" |\
	grep -v "typeinfo name for boost::property_tree::ptree_bad_path" |\
	grep -v "typeinfo name for boost::system::system_error" |\
	grep -v "typeinfo name for boost::system::error_category::std_category" |\
	grep -v "vtable for boost::property_tree::ptree_error" |\
	grep -v "vtable for boost::property_tree::ptree_bad_data" |\
	grep -v "vtable for boost::property_tree::ptree_bad_path" |\
	grep -v "vtable for boost::system::system_error" |\
	grep -v "vtable for boost::system::error_category::std_category" |\
	grep -v "boost::gil" |\
	grep -v "boost::exception" |\
	grep -v "[s|S]; vtable for "
