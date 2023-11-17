function ds_treenode() constructor {
    
    #region Internal
    
    static traverse_list = ds_list_create();
    
    static __traverse_node = function() {
        ds_list_add(traverse_list, identity);
        var _size = ds_list_size(children);
        for(var i = 0; i < _size; i ++) {
            var _child = children[| i];
            _child.__traverse_node();
        }
    }
    
    static __cleanup_deep = function() {
        var _size = ds_list_size(children);
        for(var i = 0; i < _size; i ++) {
            var _child = children[| i];
            _child.__cleanup_deep();
        }
        cleanup();
    }
    
    #endregion
    
    identity = self;
    depth = 0;
    
    data = undefined;
    parent = undefined;
    children = ds_list_create();
    
    static add_child = function(_node) {
        /// @func add_child(node)
        ds_list_add(children, _node);
        _node.set_parent(identity);
        _node.depth = depth + 1;
        return _node;
    }
    
    static add_children = function(_node) {
        /// @func add_children(node, [node2], ...[noden])
        add_child(_node);
        for(var i = 1; i < argument_count; i++){
            add_child(argument[i]);
        }
    }
    
    static get_children = function() {
        return children;
    }
    
    static set_data = function(_data) {
        /// @func set_data(data)
        data = _data;
    }
    
    static get_data = function() {
        return data;
    }
    
    static set_parent = function(_parent) {
        /// @func set_parent(parent)
        parent = _parent;
    }
    
    static get_parent = function() {
        return parent;
    }
    
    static get_identity = function() {
        return self.identity;
    }
    
    static traverse = function() {
        var _list = ds_list_create();
        __traverse_node();
        ds_list_copy(_list, traverse_list);
        ds_list_clear(traverse_list);
        return _list;
    }
    
    static get_root = function() {
        var _par = parent,
            _id = identity;
        while (_par != undefined) {
            _id = parent;
            _par = _id.parent;
        }
        return _id;
    }
    
    static cleanup = function() {
        ds_list_destroy(children);
        delete identity;
    }
    
    static cleanup_tree = function() {
        var _root = get_root();
        _root.__cleanup_deep();
    }
    
}