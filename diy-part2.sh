#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# 替换默认IP
sed -i 's#192.168.1.1#192.168.1.99#g' package/base-files/files/bin/config_generate

# cpufreq
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g' package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# 移除不用软件包
# rm -rf package/lean/luci-app-wrtbwmon
# rm -rf package/lean/luci-theme-argon

# 添加额外软件包
git clone https://github.com/ophub/luci-app-amlogic.git package/customer/luci-app-amlogic
git clone https://github.com/frainzy1477/luci-app-clash.git package/customer/luci-app-clash

# 科学上网插件依赖
git clone https://github.com/frainzy1477/luci-app-clash.git package/customer/luci-app-clash

# sagernet-core
# sed -i 's|$(LN) v2ray $(1)/usr/bin/xray|#$(LN) v2ray $(1)/usr/bin/xray|g' package/sagernet-core/Makefile
# sed -i 's|CONFLICTS:=v2ray-core xray-core|#CONFLICTS:=v2ray-core xray-core|g' package/sagernet-core/Makefile

# themes
svn co https://github.com/solidus1983/luci-theme-opentomato/trunk/luci/themes/luci-theme-opentomato package/luci-theme-opentomato
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
svn co https://github.com/rosywrt/luci-theme-purple/trunk/luci-theme-purple package/luci-theme-purple
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd

#添加smartdns
# smartdns
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2022.37/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=5a2559f0648198c290bb8839b9f6a0adab8ebcdc/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=fbe68affb4a7e3d81216c09ef9bc8d8ebc83c95aad82a4aec88b226dc4e79c3b/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2022.37/g' package/luci-app-smartdns/Makefile

#修改makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHREPO/PKG_SOURCE_URL:=https:\/\/github\.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload\.github\.com/g' {}

# docker
# sed -i 's/PKG_VERSION:=20.10.15/PKG_VERSION:=20.10.16/g' feeds/packages/utils/docker/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=af34131b1f08a068906336092a4dc3dfd8921c8039528cb698b32491951c33e2/g' feeds/packages/utils/docker/Makefile
# sed -i 's/PKG_GIT_SHORT_COMMIT:=fd82621/PKG_GIT_SHORT_COMMIT:=aa7e414/g' feeds/packages/utils/docker/Makefile

# dockerd
# sed -i 's/PKG_VERSION:=20.10.15/PKG_VERSION:=20.10.16/g' feeds/packages/utils/dockerd/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=2cd69e2cc67053300aa8d78988c92fd63ea0d0d84fe2071597191a149d5548f8/g' feeds/packages/utils/dockerd/Makefile
# sed -i 's/PKG_GIT_SHORT_COMMIT:=4433bf6/PKG_GIT_SHORT_COMMIT:=f756502/g' feeds/packages/utils/dockerd/Makefile
# sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile

# docker-compose
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.3.4/g' feeds/packages/utils/docker-compose/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=10657bbca710b7bfe7e17f259a4ab6cf69b890e7ac4b3bfc2444ef3086bd89cb/g' feeds/packages/utils/docker-compose/Makefile

# python-docker
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.0.3/g' feeds/packages/lang/python/python-docker/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=d916a26b62970e7c2f554110ed6af04c7ccff8e9f81ad17d0d40c75637e227fb/g' feeds/packages/lang/python/python-docker/Makefile

# fix luci-theme-opentomcat dockerman icon missing
rm -f package/luci-theme-opentomcat/files/htdocs/fonts/advancedtomato.woff
cp $GITHUB_WORKSPACE/general/advancedtomato.woff package/luci-theme-opentomcat/files/htdocs/fonts

# fix kernel modules missing nfs_ssc.ko
cp -f $GITHUB_WORKSPACE/general/003-add-module_supported_device-macro.patch target/linux/generic/backport-5.15
cp -f $GITHUB_WORKSPACE/general/netdevices.mk package/kernel/linux/modules

./scripts/feeds update -a
./scripts/feeds install -a
