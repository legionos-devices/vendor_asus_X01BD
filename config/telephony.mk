# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sensitive_pn.xml

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    CellBroadcastReceiver

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

