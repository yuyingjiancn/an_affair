(function($){
    $.fn.extend({
        yRecursionSelect:function(options) {
            $this = $(this);
            var YOptionModel = function (id, name) {
                this.id = ko.observable(id);
                this.name = ko.observable(name);
            }
            var YSelectModel = function (level, soptions) {
                this.level = ko.observable(level);
                this.soptions = ko.observableArray(soptions);
                this.selectedIndex = ko.observable(0);
            }
            var YRecursionSelectViewModel = function () {
                this.yRecursionSelects = ko.observableArray([]);
            }
            var yRecursionSelectViewModel = new YRecursionSelectViewModel();
            ko.applyBindings(yRecursionSelectViewModel, $this[0]);

            var ySelectModels = [];

            var generateYRecursionSelects = function (parentId) {
                var children = _.filter(options.data, function (qc) { return qc.parent_id == parentId; });

                if( children.length > 0 ) {
                    ySelectModels.push(
                        new YSelectModel(ySelectModels.length, [])
                    );

                    $.each(children, function (index, value) {
                        ySelectModels[ySelectModels.length - 1]
                            .soptions.push(new YOptionModel(value.id, value.name));
                    });

                    yRecursionSelectViewModel.yRecursionSelects.push(ySelectModels[ySelectModels.length - 1]);

                    generateYRecursionSelects(children[0].id);
                }else{
                    $this.find("input[name='ySelectedId']").val(parentId);
                }
            }

            generateYRecursionSelects(0);

            $this.foundationCustomForms();

            var selectChangeEvent = function () {
                var level = parseInt($(this).attr("level"));
                var selectedId = parseInt($(this).find("option")[$(this)[0].selectedIndex].value);
                if ( level < ySelectModels.length - 1) {
                    yRecursionSelectViewModel.yRecursionSelects.remove(function(s){ return s.level() > level });
                    generateYRecursionSelects(selectedId);
                    $this.find("select").unbind();
                    $this.find("select").change(selectChangeEvent);
                    $this.foundationCustomForms();
                } else {
                    $this.find("input[name='ySelectedId']").val(selectedId);
                }
            }

            $this.find("select").change(selectChangeEvent);
        },
        //--------------------------------------------------------------------------------------------------------------
        yRecursionSelect2:function(options) {
            var YOptionModel = function (id, name) {
                this.id = ko.observable(id);
                this.name = ko.observable(name);
            }
            var YSelectModel = function (level, soptions) {
                this.level = ko.observable(level);
                this.soptions = ko.observableArray(soptions);
                this.selectedIndex = ko.observable(0);
            }
            var YRecursionSelectViewModel = function () {
                this.yRecursionSelects = ko.observableArray([]);
            }

            $this = $(this);
            var selectedValue = parseInt($this.find("input[type='selectedValue']").val()); //获取的默认值
            console.log(selectedValue)
            var selectedItem = _.find(options.data, function (item) { return item.id == selectedValue });
            var idPath = selectedItem.parent_id_path;
            idPath.push(selectedValue);

            var yRecursionSelectViewModel = new YRecursionSelectViewModel();
            ko.applyBindings(yRecursionSelectViewModel, $this[0]);

            var ySelectModels = [];

            var generateYRecursionSelectsNow = function (idPath) {
                if ( idPath.length > 0 ) {
                    var parentId = idPath.shift();
                    var children = _.filter(options.data, function (qc) { return qc.parent_id == parentId; });

                    if( children.length > 0 ) {
                        ySelectModels.push(
                            new YSelectModel(ySelectModels.length, [])
                        );

                        $.each(children, function (index, value) {
                            ySelectModels[ySelectModels.length - 1]
                                .soptions.push(new YOptionModel(value.id, value.name));
                        });

                        yRecursionSelectViewModel.yRecursionSelects.push(ySelectModels[ySelectModels.length - 1]);

                        if(idPath.length > 0) {
                            var selectedId = idPath[0];
                            var selectedOption = _.find(children, function (qc) { return qc.id == selectedId } );
                            var selectedIndex = _.indexOf(children, selectedOption)
                            $this.find("select[level='" + (ySelectModels.length - 1) + "']")[0].selectedIndex = selectedIndex;
                            ySelectModels[ySelectModels.length - 1].selectedIndex(selectedIndex);
                        }
                    }
                    generateYRecursionSelectsNow(idPath);

                }

            }
            generateYRecursionSelectsNow(idPath);
            $this.foundationCustomForms();


            var generateYRecursionSelects = function (parentId) {
                var children = _.filter(options.data, function (qc) { return qc.parent_id == parentId; });

                if( children.length > 0 ) {
                    ySelectModels.push(
                        new YSelectModel(ySelectModels.length, [])
                    );

                    $.each(children, function (index, value) {
                        ySelectModels[ySelectModels.length - 1]
                            .soptions.push(new YOptionModel(value.id, value.name));
                    });

                    yRecursionSelectViewModel.yRecursionSelects.push(ySelectModels[ySelectModels.length - 1]);

                    generateYRecursionSelects(children[0].id);
                }else{
                    $this.find("input[type='selectedValue']").val(parentId);
                }
            }



            var selectChangeEvent = function () {
                var level = parseInt($(this).attr("level"));
                var selectedId = parseInt($(this).find("option")[$(this)[0].selectedIndex].value);
                if ( level < ySelectModels.length - 1) {
                    yRecursionSelectViewModel.yRecursionSelects.remove(function(s){ return s.level() > level });
                    generateYRecursionSelects(selectedId);
                    $this.find("select").unbind();
                    $this.find("select").change(selectChangeEvent);
                    $this.foundationCustomForms();
                } else {
                    $this.find("input[type='selectedValue']").val(selectedId);
                }
            }

            $this.find("select").change(selectChangeEvent);
        },
        //--------------------------------------------------------------------------------------------------------------
        yRecursionQuerySelect:function(options) {
            $this = $(this);
            var YOptionModel = function (id, name, allOption) {
                this.id = ko.observable(id);
                this.name = ko.observable(name);
                this.allOption = ko.observable(allOption);
            }
            var YSelectModel = function (level, soptions) {
                this.level = ko.observable(level);
                this.soptions = ko.observableArray(soptions);
                this.selectedIndex = ko.observable(0);
            }
            var YRecursionSelectViewModel = function () {
                this.yRecursionSelects = ko.observableArray([]);
            }
            var yRecursionSelectViewModel = new YRecursionSelectViewModel();
            ko.applyBindings(yRecursionSelectViewModel, $this[0]);

            var ySelectModels = [];

            var generateChildrenSelects = function (parentId) {
                var children = _.filter(options.data, function (qc) { return qc.parent_id == parentId; });

                if( children.length > 0 ) {
                    ySelectModels.push(
                        new YSelectModel(ySelectModels.length, [])
                    );

                    ySelectModels[ySelectModels.length - 1]
                        .soptions.push(new YOptionModel(parentId, "全部", true));

                    $.each(children, function (index, value) {
                        ySelectModels[ySelectModels.length - 1]
                            .soptions.push(new YOptionModel(value.id, value.name, false));
                    });

                    yRecursionSelectViewModel.yRecursionSelects.push(ySelectModels[ySelectModels.length - 1]);
                }
                $this.find("input[name='ySelectedId']").val(parentId);
            }

            //idPath肯定是从0开始
            var generateRecursionChildrenSelects = function (idPath) {
                if (idPath.length > 0) {
                    parentId = idPath.shift();
                    var children = _.filter(options.data, function (qc) { return qc.parent_id == parentId; });

                    if (children.length > 0) {
                        ySelectModels.push(new YSelectModel(ySelectModels.length, []));

                        ySelectModels[ySelectModels.length - 1]
                            .soptions.push(new YOptionModel(parentId, "全部", true));

                        $.each(children, function (index, value) {
                            ySelectModels[ySelectModels.length - 1]
                                .soptions.push(new YOptionModel(value.id, value.name, false));
                        });

                        yRecursionSelectViewModel.yRecursionSelects.push(ySelectModels[ySelectModels.length - 1]);

                        if(idPath.length > 0) {
                            var selectedId = idPath[0];
                            var selectedOption = _.find(children, function (qc) { return qc.id == selectedId } );
                            var selectedIndex = _.indexOf(children, selectedOption) + 1;//因为加了全部 所以要 +1
                            $this.find("select[level='" + (ySelectModels.length - 1) + "']")[0].selectedIndex = selectedIndex;
                            ySelectModels[ySelectModels.length - 1].selectedIndex(selectedIndex);
                        }

                        generateRecursionChildrenSelects(idPath);
                    }
                }



                $this.find("input[name='ySelectedId']").val(parentId);
            }

            var categoryId = parseInt($this.find("input[name='ySelectedId']").val());
            if (categoryId == 0){
                generateChildrenSelects(categoryId);
            } else {
                var selectedCategory = _.find(options.data, function (qc) { return qc.id == categoryId } );
                var idPath = selectedCategory.parent_id_path;
                idPath.push(selectedCategory.id);
                generateRecursionChildrenSelects(idPath);
            }

            $this.foundationCustomForms();

            var selectChangeEvent = function () {
                var level = parseInt($(this).attr("level"));
                var selectedId = parseInt($(this).find("option")[$(this)[0].selectedIndex].value);
                var allOption = $($(this).find("option")[$(this)[0].selectedIndex]).attr("all");
                if (!allOption) {
                    yRecursionSelectViewModel.yRecursionSelects.remove(function(s){ return s.level() > level });
                    generateChildrenSelects(selectedId);
                    $this.find("select").unbind();
                    $this.find("select").change(selectChangeEvent);
                    $this.foundationCustomForms();
                } else {
                    if ( level < ySelectModels.length - 1) {
                        yRecursionSelectViewModel.yRecursionSelects.remove(function(s){ return s.level() > level });
                    }
                }
                $this.find("input[name='ySelectedId']").val(selectedId);
            }

            $this.find("select").change(selectChangeEvent);
        }
    })
})(jQuery);
