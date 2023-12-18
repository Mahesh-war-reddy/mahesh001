trigger trigger_usertoemploy1 on User (before insert) {
list<user> nu =trigger.new;
    trigger_isertoemp1.usertoappl(nu);
}