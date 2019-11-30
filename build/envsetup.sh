function __print_rebellion_functions_help() {
cat <<EOF
Additional REBELLION functions:
- gerrit:          Adds a remote for AEX Gerrit
EOF
}

function repopick() {
    T=$(gettop)
    $T/vendor/rebellion/build/tools/repopick.py $@
}

function gerrit()
{
    if [ ! -d ".git" ]; then
        echo -e "Please run this inside a git directory";
    else
        if [[ ! -z $(git config --get remote.gerrit.url) ]]; then
            git remote rm gerrit;
        fi
        [[ -z "${GERRIT_USER}" ]] && export GERRIT_USER=$(git config --get gerrit.rebellionos.com.username);
        if [[ -z "${GERRIT_USER}" ]]; then
            git remote add gerrit $(git remote -v | grep Rebellion-OS | awk '{print $2}' | uniq | sed -e "s|https://github.com/Rebellion-Hub|ssh://gerrit.rebellionos.com:29418/Rebellion-OS-|");
        else
            git remote add gerrit $(git remote -v | grep Rebellion-OS | awk '{print $2}' | uniq | sed -e "s|https://github.com/Rebellion-Hub|ssh://${GERRIT_USER}@gerrit.rebellion0s.com:29418/Rebellion-OS|");
        fi
    fi
}

function fixup_common_out_dir() {
    common_out_dir=$(get_build_var OUT_DIR)/target/common
    target_device=$(get_build_var TARGET_DEVICE)
    common_target_out=common-${target_device}
    if [ ! -z $REBELLION_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_target_out} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_target_out} ${common_out_dir}
        fi
    else
        [ -L ${common_out_dir} ] && rm ${common_out_dir}
        mkdir -p ${common_out_dir}
    fi
}

# Enable SD-LLVM if available
if [ -d $(gettop)/vendor/qcom/sdclang ]; then
            export SDCLANG=true
            export SDCLANG_PATH="vendor/qcom/sdclang/6.0/prebuilt/linux-x86_64/bin"
            export SDCLANG_LTO_DEFS="vendor/rebellion/sdclang/sdllvm-lto-defs.mk"
            export SDCLANG_COMMON_FLAGS="-O3 -Wno-user-defined-warnings -Wno-vectorizer-no-neon -Wno-unknown-warning-option \
-Wno-deprecated-register -Wno-tautological-type-limit-compare -Wno-sign-compare -Wno-gnu-folding-constant \
-mllvm -arm-implicit-it=always -Wno-inline-asm -Wno-unused-command-line-argument -Wno-unused-variable"
fi