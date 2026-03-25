#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )"/common.sh

function print_debug_info {
    separate "DEBUG INFO"
    
    ln
    
    echo SHELL: $SHELL
    
    ln
    
    debug "Access mode:"
    id -u
    
    ln
    
    echo PATH: $PATH
    
    ln
    
    debug "GEMS:"
    echo GEM_HOME: $GEM_HOME
    gem env
    
    ln
    
    debug "GitLab CI environment:"
    echo_padded "CI_PIPELINE_SOURCE: $CI_PIPELINE_SOURCE"
    echo_padded "CI_COMMIT_BRANCH: $CI_COMMIT_BRANCH"
    echo_padded "CI_COMMIT_REF_NAME: $CI_COMMIT_REF_NAME"
    echo_padded "CI_JOB_ID: $CI_JOB_ID"
    echo_padded "CI_PIPELINE_IID: $CI_PIPELINE_IID"
    
    ln
    
    debug "Mise version:"
    which mise
    
    separate
    ln
}
