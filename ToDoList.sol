// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract todo_list{
    struct TodoItem{
        string task;
        bool completed;
    }

    mapping (uint256 => TodoItem) public List;
    uint256 public count = 0;
    address public owner;
    event TaskCompleted(uint256 indexed id);

    constructor (){
        owner = msg.sender;
    }

    function addTask(string calldata task) onlyOwner public {
        TodoItem memory item = TodoItem({ task: task, completed: false});
        List[count] = item;
        count++;
    }

    function completeTask(uint256 id) onlyOwner public {
        if (!List[id].completed){
            List[id].completed = true;
            emit TaskCompleted(id);
        }
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only Owner can call this");
        _;
    }
}