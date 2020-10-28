from main.models.mlm_user_hierarchy import UserHierarchy
from main.models.mlm_user_profile import UserProfile
from django.contrib.auth.models import User

def get_all_child(user_id,level,no_of_node=0,course=0):
    #
    level+=1
    if level > 4 : # Don't go byond the 4th level
        level=0
        return no_of_node

    no_of_node+=1
    #print("No of node",no_of_node)
    child_ds=UserHierarchy.objects.filter(parent_id=user_id)
    for child_d in child_ds:
        no_of_node=get_all_child(child_d.user_id,level,no_of_node)

    #print("Level",user_id,level)
    level=0 # reset the level when it reaches the final node of a path

    return no_of_node


def get_paid_child(user_id,level,no_of_node=0,course=0):
    level+=1
    # Iterate from parent, upto 4 level
    # Go through child one by one
    # check if paid
    p_auth_user_obj = User.objects.get(id=user_id)
    p_user_profile_obj = UserProfile.objects.get(auth_user_id=user_id)
    if level > 4 or p_user_profile_obj.payment_status =='notpaid': # Don't go byond the 4th level
        level=0
        return no_of_node


    no_of_node+=1
    #print("No of node",no_of_node)
    child_ds=UserHierarchy.objects.filter(parent_id=user_id)
    for child_d in child_ds:
        no_of_node=get_paid_child(child_d.user_id,level,no_of_node)

    #print("Level",user_id,level)
    level=0 # reset the level when it reaches the final node of a path

    return no_of_node

def get_depth(user_id,course,depth):
    depth+=1
    # Stop at 4th level
    if depth > 3:
        return depth

    uh=UserHierarchy.objects.filter(parent_id=user_id,course=course).order_by('id').first()
    if uh:
        depth=get_depth(uh.user_id,course,depth)

    return depth

def get_root_node(user_id,depth):
    # Stop at 4th level
    p_auth_user_obj = User.objects.get(id=user_id)
    p_user_profile_obj = UserProfile.objects.get(auth_user_id=user_id)
    if depth == 3:
        return p_auth_user_obj

    user_h_ds=UserHierarchy.objects.filter(user_id=user_id)

    if user_h_ds:
        user_h_obj=user_h_ds.get()
        depth+=1
        p_auth_user_obj=get_root_node(user_h_obj.parent_id,depth)


    return p_auth_user_obj

def get_user_hierarchy(user_id,level=0,ha_list=[],course=0,depth=0):
    level+=1
    if level > 4 : # Don't go byond the 4th level
        level=0
        return "student"

    p_auth_user_obj = User.objects.get(id=user_id)
    p_user_profile_obj = UserProfile.objects.get(auth_user_id=user_id)
    image="/static/img/nobody.jpg"
    if p_user_profile_obj.picture:
        image=p_user_profile_obj.picture.url
    payment_status="Not Paid"
    if p_user_profile_obj.payment_status =='paid':
        payment_status="Paid"


    data={
        "text": {
            "name": p_auth_user_obj.first_name+" "+p_auth_user_obj.last_name,
            "title": 'student',
            "desc": payment_status
        },
        "image": image,
        "children": []
    }

    ha_list.append(data)
    user_h_ds=UserHierarchy.objects.filter(parent_id=user_id,course=course)
    for uh in user_h_ds:
        user_role=get_user_hierarchy(uh.user_id,level,data['children'],course,depth)

    print("level",user_id,level,depth)
    if level == depth:
        user_role = "student"
    elif level == depth-1:
        user_role = "prefect"
    elif level == depth-2:
        user_role = "bursar"
    elif level == depth-3:
        user_role = "scholar"

    level=0

    data['text']['title']=user_role
    return user_role
