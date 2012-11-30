# -*- coding: utf-8 -*-
$question_categories_sign_by_id = {}

class QuestionCategory
  attr_reader :id, :name, :order, :children, :child_ids, :parent, :parent_id, :is_leaf,  :leafs, :leaf_ids, :parent_path, :parent_id_path

  # @param id [int]
  # @param name [string]
  # @param children [Array]
  # @param parent [QuestionCategory]
  # @param order [int]
  # @param parent_path [Array]
  def initialize(id, name, children, parent = nil, order = 0, parent_path = Array.new)
    @id = id
    @name = name
    @order = order
    @parent = parent
    @children = Array.new
    @child_ids = Array.new
    @leafs = Array.new
    @leaf_ids = Array.new

    @parent_path = parent_path
    @parent_id_path = Array.new

    if children.nil?
      @is_leaf = true
    else
      @is_leaf = false
      order = 0
      children.each do |child|
        @children.append(QuestionCategory.new(child[:id], child[:name], child[:children], self, order, Array.new(@parent_path).push(self)))
        @child_ids.push(child[:id])
        order += 1
      end
    end

    @parent_id = parent.id if !parent.nil?


    set_parent_leafs(self) if @is_leaf
    @leafs.each { |leaf| @leaf_ids.append(leaf.id) } unless @is_leaf

    @parent_path.each { |p| @parent_id_path.push(p.id)  } unless @parent_path.nil?

    $question_categories_sign_by_id[@id] = self
  end

  def set_parent_leafs(leaf)
    unless @parent.nil?
      @parent.leafs.append(leaf)
      @parent.set_parent_leafs(leaf)
    end
  end
end

#定义系统主分类
question_categories_hash =
{ :id => 0,  :name => "root", :children => [
    {:id => 1, :name => "信息技术基础", :children => [
        {:id => 2, :name => "信息与信息技术", :children => [
            {:id => 9, :name => "信息及特征"},
            {:id => 10, :name => "信息的编码"},
            {:id => 11, :name => "信息技术"}
        ]},
        {:id => 3, :name => "信息的来源与获取", :children => [
            {:id => 12, :name => "信息的获取方法"},
            {:id => 13, :name => "因特网上信息的浏览与获取"},
            {:id => 14, :name => "网上资源检索"},
            {:id => 15, :name => "因特网信息资源评价"}
        ]},
        {:id => 4, :name => "信息的加工", :children => [
            {:id => 16, :name => "现代信息处理工具-计算机"},
            {:id => 17, :name => "字处理和表处理"},
            {:id => 18, :name => "多媒体信息处理"},
            {:id => 20, :name => "智能处理"}
        ]},
        {:id => 5, :name => "信息的管理", :children => [
            {:id => 21, :name => "信息资源管理及其沿革"},
            {:id => 22, :name => "数据库系统"}
        ]},
        {:id => 6, :name => "信息的表达与交流", :children => [
            {:id => 23, :name => "信息表达"},
            {:id => 24, :name => "电子邮件"},
            {:id => 25, :name => "电子公告板、在线游戏"}
        ]},
        {:id => 7, :name => "网页的设计与制作",  :children => [
            {:id => 26, :name => "网站和网页"},
            {:id => 27, :name => "网页制作"},
        ]},
        {:id => 8, :name => "信息技术与社会",  :children => [
            {:id => 28, :name => "信息技术对人类社会的影响"},
            {:id => 29, :name => "知识产权"},
            {:id => 30, :name => "信息的安全与保护"},
            {:id => 31, :name => "做信息时代的合格公民"}
        ]}
    ]},
    {:id => 101, :name => "多媒体技术应用", :children => [
        {:id => 102, :name => "多媒体技术与社会生活",  :children => [
            {:id => 106, :name => "走进多媒体世界"},
            {:id => 107, :name => "多媒体技术在社会生活中的应用"},
            {:id => 108, :name => "多媒体技术的现状和发展"},
            {:id => 109, :name => "多媒体计算机系统"}
        ]},
        {:id => 103, :name => "多媒体作品设计",  :children => [
            {:id => 110, :name => "作品的需求分析"},
            {:id => 111, :name => "作品的规划与设计"},
            {:id => 112, :name => "脚本编写"}
        ]},
        {:id => 104, :name => "媒体的采集与制作", :children => [
            {:id => 113, :name => "多媒体数据文件"},
            {:id => 114, :name => "文本素材"},
            {:id => 115, :name => "图片素材"},
            {:id => 116, :name => "声音素材"},
            {:id => 117, :name => "动画素材"},
            {:id => 118, :name => "视频素材"}
        ]},
        {:id => 105, :name => "作品的合成与递交", :children => [
            {:id => 119, :name => "多媒体作品创作工具"},
            {:id => 120, :name => "多媒体作品的合成"},
            {:id => 121, :name => "作品的调试与递交"}
        ]},
    ]},
    {:id => 201, :name => "算法及其实现", :children => [
        {:id => 202, :name => "算法含义、表示方法"},
        {:id => 203, :name => "对象、属性、类、方法、事件及事件处理"},
        {:id => 204, :name => "VB程序界面、控件"},
        {:id => 205, :name => "基本数据类型、变量、常量、一维数组"},
        {:id => 206, :name => "标准函数、算术、关系、逻辑运算、表达式"},
        {:id => 207, :name => "语句、三种基本控制结构"},
        {:id => 208, :name => "算法的综合运用与程序实现"}
    ]},
    {:id => 9999, :name => "其它"}
]}

$question_root = QuestionCategory.new(question_categories_hash[:id], question_categories_hash[:name], question_categories_hash[:children])
$question_categories = []
$question_categories_sign_by_id.each do |k, v|
  $question_categories.push({
    :id => v.id,
    :name => v.name,
    :order => v.order,
    :child_ids => v.child_ids,
    :parent_id => v.parent_id,
    :is_leaf => v.is_leaf,
    :leaf_ids => v.leaf_ids,
    :parent_id_path => v.parent_id_path
  })
end




