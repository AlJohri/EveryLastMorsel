var overlayAnimSpeed = 150;

function numberCommas(amt) {
    amt += '';
    amtArray = amt.split('.');
    leftHalf = amtArray[0];
    rightHalf = amtArray.length > 1 ? '.' + amtArray[1] : '';
    var re = /(\d+)(\d{3})/;
    if (leftHalf.length >= 5) {
        while (re.test(leftHalf)) {
            leftHalf = leftHalf.replace(re, '$1' + ',' + '$2');
        }
    }
    return leftHalf + rightHalf;
}

function customRound(value, increment) {
    var result;
    var remain = value % increment;
    var roundvalue = increment / 2;
    if (remain >= roundvalue) {
        result = value - remain;
        result += increment;
    } else {
        result = value - remain;
    }
    return result;
}
var ajaxFeedbackShowing = false;
var feedbackSlideDuration = 100;

function showAjaxFeedback() {
    $('div.ajaxfeedback').animate({
        bottom: 0
    }, feedbackSlideDuration);
    ajaxFeedbackShowing = true;
}

function hideAjaxFeedback() {
    $('div.ajaxfeedback').animate({
        bottom: 0 - $('div.ajaxfeedback').outerHeight()
    }, feedbackSlideDuration);
    $('div.ajaxfeedback span.icon').html('');
    $('div.ajaxfeedback span.message').html('');
    ajaxFeedbackShowing = false;
}

function loadingBegin() {
    $('div.ajaxfeedback span.icon').html('<img class="loading" src="loading-highlight-bkgd.gif" alt="Loading&hellip;"/>');
    $('div.ajaxfeedback span.message').html('Loading&hellip;');
    showAjaxFeedback();
}

function loadingEnd() {
    hideAjaxFeedback();
}

function savingBegin() {
    $('div.ajaxfeedback span.icon').html('<img class="loading" src="loading-highlight-bkgd.gif" alt="Saving&hellip;"/>');
    $('div.ajaxfeedback span.message').html('Saving&hellip;');
    showAjaxFeedback();
}

function savingEnd(fail) {
    if (fail == null) {
        if (!ajaxFeedbackShowing) {
            showAjaxFeedback();
        }
        $('div.ajaxfeedback span.icon').html('<img class="loading" src="tick.png" alt="Saved"/>');
        $('div.ajaxfeedback span.message').html('Saved');
        setTimeout(function () {
            hideAjaxFeedback();
        }, 1250);
    } else {
        hideAjaxFeedback();
    }
}

function showError(msg) {
    if (msg == null) {
        msg = 'There�s an error with that.';
    }
    $('div.ajaxfeedback span.icon').html('<img class="loading" src="error-mark.png" alt="Error"/>');
    $('div.ajaxfeedback span.message').html(msg);
    showAjaxFeedback();
    setTimeout(function () {
        hideAjaxFeedback();
    }, 3000);
}

function formLoadingOn(form) {
    var submitWrap = form.find('.submit');
    if (submitWrap.find('img.loading').length > 0) {
        form.find('input[type="submit"]').hide();
        submitWrap.find('img.loading').show();
    }
}

function formLoadingOff(form) {
    var submitWrap = form.find('.submit');
    if (submitWrap.find('img.loading').length > 0) {
        submitWrap.find('img.loading').hide();
        form.find('input[type="submit"]').show();
    }
}

function recomputeCrop(evt) {
    evt.preventDefault();
    var form = $(this).parents('form');
    if ($(this).parents('.forxweeks').length > 0) {
        if (parseInt($(this).val()) == 1) {
            $(this).siblings('label.weekspostlabel').html('week');
        } else {
            $(this).siblings('label.weekspostlabel').html('weeks');
        }
    }
    if (parseInt(form.find('input[name$="plantings_count"]').val()) == 1) {
        form.find('.plantingscountlabel').html('planting');
        form.find('.plantingscountlabel2').html('');
        form.find('.plantingscountlabel3').html('');
    } else {
        form.find('.plantingscountlabel').html('plantings');
        form.find('.plantingscountlabel2').html(' each time');
        form.find('.plantingscountlabel3').html('/planting');
    }
    var totalAmt = parseFloat(form.find('input[name$="total_for_year"]').val());
    if (form.find('input[name$="amt_type"]').val() == 'perweek') {
        totalAmt = parseFloat(form.find('input[name$="amt_per_week"]').val()) * parseFloat(form.find('input[name$="for_n_weeks"]').val());
    }
    var yieldPerRf = parseFloat(form.find('input[name$="yield_per_rf"]').val());
    var rowsPerBed = parseFloat(form.find('input[name$="rows_per_bed"]').val());
    var totalBedFeet = totalAmt / yieldPerRf / rowsPerBed;
    var totalBeds = totalBedFeet / parseFloat($('span#fieldbedlength').html());
    var bedsPerPlanting = totalBeds / parseInt(form.find('input[name$="plantings_count"]').val())
    var bedFeetPerPlanting = totalBedFeet / parseInt(form.find('input[name$="plantings_count"]').val());
    var bedsPerPlantingRounded = customRound(bedsPerPlanting, parseFloat(form.find('input[name$="bed_rounding"]').val()));
    if (isNaN(bedsPerPlantingRounded)) {
        bedsPerPlantingRounded = bedsPerPlanting;
    }
    if (bedsPerPlanting == 1) {
        form.find('.bedsperplantinglabel').html('bed');
    } else {
        form.find('.bedsperplantinglabel').html('beds');
    }
    if (!isNaN(bedsPerPlantingRounded) && !isNaN(bedFeetPerPlanting)) {
        form.find('span.bedsperplanting').html(numberCommas(bedsPerPlantingRounded));
        form.find('span.bedfeetperplanting').html(numberCommas(Math.round(bedFeetPerPlanting)));
    }
}

function recomputePlanting(evt) {
    evt.preventDefault();
    var form = $(this).parents('form');
    var yieldPerRf = parseFloat(form.find('input[name$="est_yield_per_rf"]').val());
    var rowsPerBed = parseFloat(form.find('input[name$="rows_per_bed"]').val());
    var totalYield = parseFloat(form.find('input[name$="est_total_yield"]').val());
    var bedCount = parseFloat(form.find('input[name$="beds"]').val());
    var bedRounding = parseFloat(form.find('input[name$="bed_rounding"]').val());
    var bedLength = parseFloat($('span#fieldbedlength').html());
    if ($(this).attr('name') == 'beds') {
        totalYield = bedCount * bedLength * yieldPerRf * rowsPerBed;
        if (!isNaN(totalYield)) {
            form.find('input[name$="est_total_yield"]').val(totalYield);
        }
    } else {
        bedCount = totalYield / yieldPerRf / rowsPerBed / bedLength;
        if (!isNaN(bedCount)) {
            var bedCountRounded = customRound(bedCount, parseFloat(form.find('input[name$="bed_rounding"]').val()));
            if (!isNaN(bedCountRounded)) {
                form.find('input[name$="beds"]').val(bedCountRounded);
            }
        }
    }
}

function setFieldWidth() {
    if ($('div.fieldsidebarwrap').innerWidth() > 0) {
        $('div.fieldcontainer').removeClass('wide');
    } else {
        if ($('div.fieldcontainer').hasClass('wide') == false) {
            $('div.fieldcontainer').addClass('wide');
        }
    }
}

function getPlantWrapper(kid) {
    var wrapper = false;
    if (kid.closest('div.variety').length > 0) {
        wrapper = kid.closest('div.variety');
    } else {
        wrapper = kid.closest('div.plant');
    }
    return wrapper
}

function getPlantingForm(evt) {
    evt.preventDefault();
    if ($(this).find('div.plantingeditorwrap').length == 0) {
        loadingBegin();
        $('div.fieldcontainer div.plantingeditorwrap').remove();
        $('div.successions span.succession').removeClass('editon dragon resizeon');
        var targetPlanting = $(this);
        var planting_id = targetPlanting.find('form.plantingdata input[name$="planting_id"]').val();
        var farm_id = targetPlanting.find('form.plantingdata input[name$="planting_id"]').val();
        var field_id = targetPlanting.find('form.plantingdata input[name$="planting_id"]').val();
        $.ajax({
            data: {
                'planting_id': planting_id,
                'farm_id': farm_id,
                'field_id': field_id
            },
            url: '/farm/getplantingform/',
            success: function (data, textStatus, xhr) {
                loadingEnd();
                if (data.success) {
                    var plantingForm = $(data.html_response);
                    targetPlanting.append(plantingForm)
                    targetPlanting.find('div.tooltipwrap').fadeOut(overlayAnimSpeed);
                    targetPlanting.addClass('editon');
                } else {
                    showError(data.html_response);
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                loadingEnd();
                showError('There was an error with that.');
            }
        });
    }
}

function plantingEdit(evt) {
    evt.preventDefault();
    var targetForm = $(this).closest('form.planting');
    var targetPlanting = targetForm.closest('span.succession');
    var wrapper = getPlantWrapper(targetForm);
    formLoadingOn(targetForm);
    savingBegin();
    $.ajax({
        data: targetForm.serialize(),
        url: '/farm/plantingedit/',
        success: function (data, textStatus, xhr) {
            formLoadingOff(targetForm);
            if (data.success) {
                wrapper.find('div.successions').replaceWith(data.html_response);
                targetPlanting.removeClass('editon');
                savingEnd();
                if (data.field_id && data.year) {
                    recomputeBedUsage(data.field_id, data.year);
                }
            } else {
                savingEnd('fail');
                var plantingForm = $(data.html_response);
                targetPlanting.find('div.plantingeditorwrap').remove();
                targetPlanting.append(plantingForm)
            }
            return false;
        },
        error: function (xhr, textStatus, errorThrown) {
            formLoadingOff(targetForm);
            savingEnd('fail');
            showError('There was an error with that.');
            return false;
        }
    });
    return false;
}

function recomputeBedUsage(fieldId, year) {
    $('div.graph.fieldfullness').find('img.loading').show();
    $.ajax({
        data: {
            'field_id': fieldId,
            'year': year
        },
        url: '/farm/fieldfullness/',
        success: function (data, textStatus, xhr) {
            if (data.success) {
                $('div.graph.fieldfullness').replaceWith(data.new_graph);
            }
        },
        complete: function () {
            $('div.graph.fieldfullness').find('img.loading').hide();
        }
    });
}

function makeDateFromPosition(pos, container, year) {
    var yearStart = new Date(year, 0, 1);
    var yearEnd = new Date(year, 11, 31, 23, 59, 59, 999);
    var timeElapsed = pos / container * (yearEnd - yearStart);
    var date = new Date();
    date.setTime(yearStart.getTime() + timeElapsed);
    return date;
}

function setPlantingDatesByPosition(planting) {
    if (planting.position() != null) {
        var wrapperWidth = planting.closest('div.successions').width();
        var plantingInput = planting.find('form.plantingdata:first input[name$="est_planting_date"]:first');
        plantingDateArray = plantingInput.val().split('-');
        var harvestInput = planting.find('form.plantingdata:first input[name$="est_harvest_date"]:first');
        harvestDateArray = harvestInput.val().split('-');
        var plantingYear = new Date(parseInt(plantingDateArray[0], 10), parseInt(plantingDateArray[1], 10) - 1, parseInt(plantingDateArray[2], 10));
        plantingYear = plantingYear.getFullYear();
        var harvestYear = new Date(parseInt(harvestDateArray[0], 10), parseInt(harvestDateArray[1], 10) - 1, parseInt(harvestDateArray[2], 10));
        harvestYear = harvestYear.getFullYear();
        var plantingDate = makeDateFromPosition(planting.position().left, wrapperWidth, plantingYear);
        var harvestDate = makeDateFromPosition(planting.position().left + planting.width(), wrapperWidth, harvestYear);
        planting.find('div.tooltipwrap.planting div.tooltip span.date').html(formatDate(plantingDate));
        planting.find('div.tooltipwrap.harvest div.tooltip span.date').html(formatDate(harvestDate));
        plantingInput.val(formatDate(plantingDate, true));
        harvestInput.val(formatDate(harvestDate, true));
    }
}

function formatDate(date, machine, longMonths, year) {
    var dateStr;
    if (machine) {
        var bumpedMonth = date.getMonth() + 1;
        dateStr = date.getFullYear() + '-' + bumpedMonth + '-' + date.getDate();
    } else {
        var shortMonthNames = new Array('Jan.', 'Feb.', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sept.', 'Oct.', 'Nov.', 'Dec.');
        var longMonthNames = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
        var month;
        if (longMonths) {
            month = longMonthNames[date.getMonth()];
        } else {
            month = shortMonthNames[date.getMonth()];
        }
        dateStr = month + ' ' + date.getDate();
        if (year) {
            dateStr += ', ' + date.getFullYear();
        }
    }
    return dateStr;
}

function resetPlantingPosition(planting) {
    var origLeft = planting.find('span.originalstyle.left').html();
    var origWidth = planting.find('span.originalstyle.width').html();
    planting.css('left', origLeft);
    planting.css('width', origWidth);
    setPlantingDatesByPosition(planting);
}

function reschedulePlanting(planting, formData) {
    savingBegin();
    var wrapper = getPlantWrapper(planting);
    $.ajax({
        data: formData,
        url: '/farm/plantingdatesedit/',
        success: function (data, textStatus, xhr) {
            if (data.success) {
                savingEnd();
                wrapper.find('div.successions').replaceWith(data.new_successions);
                recomputeBedUsage(data.field_id, data.year);
            } else {
                savingEnd('fail');
                showError(data.error_msg);
                resetPlantingPosition(planting);
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            savingEnd('fail');
            showError('There was an error with that.');
            resetPlantingPosition(planting);
        }
    });
}
var sidebarOrigTop;

function calcSidebarTop() {
    var cropAdder = $('div.cropadder');
    if ($('div.cropadder').offset() != null) {
        sidebarOrigTop = $('div.cropadder').offset().top;
    }
}

$(document).ready(function () {
    // var IS_IE = $.browser.msie ? true : false;
    var IS_IE = false;
    var CHANGE_EVT = IS_IE ? 'click' : 'change';
    $.ajaxSetup({
        type: 'POST',
        dataType: 'json',
        timeout: 15000
    });
    $('input[placeholder]').placeHeld();
    $('.autofocus:first').focus();
    setTimeout(function () {
        notificationHeight = $('div#notifications').outerHeight();
        $('div#notifications').slideUp(overlayAnimSpeed);
        sidebarOrigTop -= notificationHeight;
    }, 7000);
    $('form.stdform').submit(function () {
        formLoadingOn($(this));
    });
    $('a.forgotpassword').click(function (evt) {
        evt.preventDefault();
        var forgot = $('form.forgotpassword');
        if (forgot.is(':visible')) {
            forgot.slideUp(overlayAnimSpeed);
            $('form.login ul :input:first').focus();
        } else {
            forgot.slideDown(overlayAnimSpeed);
            forgot.find('ul :input:first').focus();
        }
    });
    $('form.closefarmaccount').submit(function () {
        var sure = confirm('Just making certain: are you sure you want to close your account? Click OK if you are.');
        if (!sure) {
            return false;
        }
    });
    $('a.revokeuseraccess').click(function (evt) {
        var sure = confirm('Are you sure you want to revoke this user\'s access? They will no longer be able to access the farm\'s information at all.');
        if (sure) {
            window.location = $(this).attr('href');
        }
        return false;
    });
    $('a.addfield').click(function (evt) {
        evt.preventDefault();
        if (!$('div#addfieldform').is(':visible')) {
            if ($('div#editfieldform').is(':visible')) {
                $('div#editfieldform').slideUp(overlayAnimSpeed);
            }
            $('div#addfieldform').slideDown(overlayAnimSpeed, function () {
                sidebarOrigTop = $('div.cropadder').offset().top;
            });
            setFieldWidth();
        } else {
            $('div#addfieldform').slideUp(overlayAnimSpeed, function () {
                sidebarOrigTop = $('div.cropadder').offset().top;
                setFieldWidth();
            });
        }
    });
    $('a.editfield').click(function (evt) {
        evt.preventDefault();
        if (!$('div#editfieldform').is(':visible')) {
            if ($('div#addfieldform').is(':visible')) {
                $('div#addfieldform').slideUp(overlayAnimSpeed);
            }
            $('div#editfieldform').slideDown(overlayAnimSpeed, function () {
                sidebarOrigTop = $('div.cropadder').offset().top;
            });
            setFieldWidth();
        } else {
            $('div#editfieldform').slideUp(overlayAnimSpeed, function () {
                sidebarOrigTop = $('div.cropadder').offset().top;
                setFieldWidth();
            });
        }
    });
    $('form.fieldeditform').submit(function (evt) {
        evt.preventDefault();
        var targetForm = $(this);
        var formWrap = targetForm.parents('div.fieldeditform');
        $.ajax({
            data: targetForm.serialize(),
            url: '/farm/fieldedit/',
            success: function (data, textStatus, xhr) {
                if (data.success) {
                    if (data.redirect_url) {
                        window.location = data.redirect_url;
                    } else {
                        formLoadingOff(targetForm);
                        formWrap.slideUp(overlayAnimSpeed, function () {
                            setFieldWidth();
                        });
                    }
                } else {
                    formLoadingOff(targetForm);
                    formWrap.html(data.html_response);
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                formLoadingOff(targetForm);
                showError('There was an error with that.');
            }
        });
    });
    $('a.addcrop').click(function (evt) {
        evt.preventDefault();
        if ($('div.cropadder').is(':visible')) {
            $('div.cropadder').slideUp(overlayAnimSpeed, function () {
                setFieldWidth();
            });
        } else {
            $('div.cropadder').slideDown(overlayAnimSpeed, function () {
                sidebarOrigTop = $('div.cropadder').offset().top;
            });
            setFieldWidth();
        }
    });
    $('div.cropadder div.subsectionswitcher a').click(function (evt) {
        evt.preventDefault();
        if (!$(this).hasClass('selected')) {
            $(this).parent().children('a').removeClass('selected');
            $(this).addClass('selected');
            var amt_type = '';
            if ($(this).hasClass('amtperweektrigger')) {
                $('div.totalforyearwrap').hide();
                $('div.amtperweekwrap').show();
                amt_type = 'perweek';
            } else if ($(this).hasClass('totalforyeartrigger')) {
                $('div.amtperweekwrap').hide();
                $('div.totalforyearwrap').show();
                amt_type = 'total';
            }
            $(this).parents('form').find('input[name$="amt_type"]').val(amt_type);
        }
        $('div.cropadder form :input').trigger('change');
    });
    $('form span.bedrounding a').click(function (evt) {
        evt.preventDefault();
        var parentForm = $(this).parents('form');
        if (!$(this).hasClass('selected')) {
            $(this).parent().children('a').removeClass('selected');
            $(this).addClass('selected');
        }
        var roundingValue = parseFloat($(this).attr('href').substring(1));
        if (!isNaN(roundingValue)) {
            parentForm.find('input[name$="bed_rounding"]').val(roundingValue);
        }
        parentForm.find(':input').trigger('change');
    });
    $('form select').change(function (evt) {
        if (IS_IE) {
            var parent = $(this).closest('span.succession');
            parent.addClass('changingunit');
        }
        if ($(this).hasClass('yieldunit')) {
            var newVal = $(this).val();
            $(this).parents('form').find('select.yieldunit').each(function () {
                $(this).val(newVal);
            });
        }
        if (IS_IE) {
            setTimeout(function () {
                parent.removeClass('changingunit');
            }, 1000);
        }
        return false;
    });
    $('div.cropadder form :input').keyup(recomputeCrop);
    $('form.cropaddform').submit(function (evt) {
        evt.preventDefault();
        var targetForm = $(this);
        var formWrap = targetForm.parents('div.cropadder');
        $.ajax({
            data: $(this).serialize(),
            url: '/farm/cropedit/',
            success: function (data, textStatus, xhr) {
                if (data.success) {
                    if (data.redirect_url) {
                        window.location = data.redirect_url;
                    } else {
                        formLoadingOff(targetForm);
                        formWrap.slideUp(overlayAnimSpeed, function () {
                            setFieldWidth();
                        });
                    }
                } else {
                    formLoadingOff(targetForm);
                    formWrap.html(data.html_response);
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                formLoadingOff(targetForm);
                showError('There was an error with that.');
            }
        });
    });
    $('form.planting a.growthinfo').click(function (evt) {
        evt.preventDefault();
        var growthInfo = $(this).parents('form').find('li.growthinfo');
        if (growthInfo.is(':visible')) {
            growthInfo.slideUp(overlayAnimSpeed);
        } else {
            growthInfo.slideDown(overlayAnimSpeed);
        }
    });
    $('form.planting :input').keyup(recomputePlanting);
    $('div.successions span.succession').hover(function (evt) {
        if (evt.type == 'mouseover') {
            $(this).addClass('hoveron');
            if ($(this).hasClass('editon') == false) {
                $(this).find('div.tooltipwrap').fadeIn(overlayAnimSpeed);
            }
        } else if ($(this).hasClass('dragon') == false && $(this).hasClass('resizeon') == false) {
            $(this).find('div.tooltipwrap').fadeOut(overlayAnimSpeed);
            $(this).removeClass('hoveron');
        } else {
            $(this).removeClass('hoveron');
        }
    });

    $(document).click(function () {
        $('div.successions span.succession.editon').not('.hoveron').not('.changingunit').removeClass('editon dragon resizeon').find('div.plantingeditorwrap').remove();
    });

    $('div.plantingeditorwrap a.canceledit').click(function (evt) {
        evt.preventDefault();
        evt.stopPropagation();
        $(this).closest('span.succession').removeClass('editon dragon resizeon');
        $(this).closest('div.plantingeditorwrap').remove();
        return false;
    });

    var lastSuccessionMousedown = new Date().getTime();

    var successionAwaitsMouseup = false;

    var BEGIN_DRAG_DELAY = 250;

    $('div.successions span.succession').on('fetchPlantingForm', getPlantingForm);

    $('div.successions span.succession').mousedown(function (evt) {
        lastSuccessionMousedown = new Date().getTime();
        if (!$(this).hasClass('editon')) {
            successionAwaitsMouseup = true;
        }
    });

    $('div.successions span.succession').mouseup(function (evt) {
        var now = new Date().getTime();
        if (now - lastSuccessionMousedown < BEGIN_DRAG_DELAY) {
            $(this).trigger('fetchPlantingForm');
            successionAwaitsMouseup = false;
        }
    });

    $('div.plant .addplanting').click(function (evt) {
        evt.preventDefault();
        loadingBegin();
        var wrapper = getPlantWrapper($(this));
        var lastPlantingId = wrapper.find('div.successions span.succession:last input[name$="planting_id"]').val();
        $.ajax({
            data: {
                'last_planting_id': lastPlantingId
            },
            url: '/farm/plantingadd/',
            success: function (data, textStatus, xhr) {
                loadingEnd();
                if (data.success) {
                    wrapper.find('div.successions').replaceWith(data.html_response);
                    wrapper.find('div.successions span.succession:last').trigger('click');
                    if (data.field_id && data.year) {
                        recomputeBedUsage(data.field_id, data.year);
                    }
                } else {
                    showError(data.html_response);
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                loadingEnd();
                showError('There was an error with that.');
            }
        });
    });

    $('div.plant .deleteplanting').click(function (evt) {
        evt.preventDefault();
        var sure = confirm('Are you sure you want to delete this planting?');
        if (sure) {
            loadingBegin();
            var targetPlanting = $(this).closest('span.succession');
            var wrapper = getPlantWrapper($(this));
            var plantingId = $(this).closest('form').find('input[name$="planting_id"]').val();
            $.ajax({
                data: {
                    'planting_id': plantingId
                },
                url: '/farm/plantingdelete/',
                success: function (data, textStatus, xhr) {
                    loadingEnd();
                    if (data.success) {
                        targetPlanting.remove();
                        if (wrapper.find('div.successions span.succession').length == 0) {
                            window.location.reload();
                        } else {
                            if (data.field_id && data.year) {
                                recomputeBedUsage(data.field_id, data.year);
                            }
                        }
                    } else {
                        showError(data.html_response);
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    loadingEnd();
                    showError('There was an error with that.');
                }
            });
        }
    });

    $('div.plantingeditorwrap form.planting').submit(plantingEdit);

    $('div.plantingeditorwrap').mouseup(function (evt) {
        evt.stopPropagation();
        return false;
    });

    $('div.graph.fieldfullness').removeClass('jsdisabled');

    $('div.graph.fieldfullness div.bar').mouseenter(function (evt) {
        $(this).siblings().removeClass('hovered');
        $(this).addClass('hovered');
    });

    $('div.graph.fieldfullness div.bar').mouseleave(function (evt) {
        var target = $(this);
        setTimeout(function () {
            target.removeClass('hovered');
        }, 200);
    });

    var dragBeginMouseX = null;
    var dragBeginPlantingX = null;
    var resizeBeginMouseX = null;
    var resizeBeginPlantingX = null;

    $('div.successions span.succession div.draghandle.whole').mousedown(function (evt) {
        var targetPlanting = $(this).closest('span.succession');
        if (targetPlanting.hasClass('editon') == false) {
            evt.preventDefault();
            dragBeginMouseX = evt.pageX;
            dragBeginPlantingX = targetPlanting.position().left;
            targetPlanting.addClass('dragon');
        }
    });

    $('div.successions span.succession div.draghandle.harvest').mousedown(function (evt) {
        var targetPlanting = $(this).closest('span.succession');
        if (targetPlanting.hasClass('editon') == false) {
            evt.preventDefault();
            resizeBeginMouseX = evt.pageX;
            resizeBeginPlantingX = targetPlanting.width();
            targetPlanting.addClass('resizeon');
        }
    });

    $(document).mousemove(function (evt) {
        var MIN_PLANTING_WIDTH = 13;
        var now = new Date().getTime();
        if ((now - lastSuccessionMousedown >= BEGIN_DRAG_DELAY) && successionAwaitsMouseup) {
            var draggedPlanting = $('div.successions span.succession.dragon').eq(0);
            var resizedPlanting = $('div.successions span.succession.resizeon').eq(0);
            var wrapperWidth;
            if (draggedPlanting.length > 0) {
                wrapperWidth = draggedPlanting.closest('div.successions').width();
                var plantingOuterWidth = draggedPlanting.outerWidth();
                var newLeft = Math.max(0, dragBeginPlantingX + evt.pageX - dragBeginMouseX);
                draggedPlanting.css('left', Math.min(newLeft, wrapperWidth - plantingOuterWidth));
            }
            if (resizedPlanting.length > 0) {
                wrapperWidth = resizedPlanting.closest('div.successions').width();
                var newWidth = Math.min(wrapperWidth - resizedPlanting.position().left, Math.max(MIN_PLANTING_WIDTH, resizeBeginPlantingX + evt.pageX - resizeBeginMouseX));
                resizedPlanting.width(newWidth);
            }
            var affected;
            if (draggedPlanting.length > 0) {
                affected = draggedPlanting.add(resizedPlanting);
            } else {
                affected = resizedPlanting;
            }
            affected = affected.eq(0);
            setPlantingDatesByPosition(affected);
        }
    });

    $(document).mouseup(function (evt) {
        var now = new Date().getTime();
        if ((now - lastSuccessionMousedown >= BEGIN_DRAG_DELAY) && successionAwaitsMouseup) {
            var draggedPlanting = $('div.successions span.succession.dragon').eq(0);
            var resizedPlanting = $('div.successions span.succession.resizeon').eq(0);
            dragBeginMouseX = null;
            dragBeginPlantingX = null;
            resizeBeginMouseX = null;
            resizeBeginPlantingX = null;
            var affected;
            if (draggedPlanting.length > 0) {
                affected = draggedPlanting.add(resizedPlanting);
            } else {
                affected = resizedPlanting;
            }
            affected = affected.eq(0);
            var formData = affected.find('form.plantingdata').serialize();
            reschedulePlanting(affected, formData);
        }
        successionAwaitsMouseup = false;
        if (affected) {
            affected.removeClass('dragon resizeon');
            if (affected.hasClass('hoveron') == false) {
                affected.find('div.tooltipwrap').fadeOut(overlayAnimSpeed);
            }
        }
    });

});