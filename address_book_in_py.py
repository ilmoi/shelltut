contacts = [
    {
        'name': 'ilja moi',
        'phone': 123456789,
        'email': 'iljamoi@gmail.com'
    },
    {
        'name': 'jia gao',
        'phone': 234567891,
        'email': 'jiagao@gmail.com'
    },
    {
        'name': 'dan duma',
        'phone': 345678912,
        'email': 'danduma@gmail.com'
    },
    {
        'name': 'ilja duma',
        'phone': 456789123,
        'email': 'iljaduma@gmail.com'
    }
]


def search():
    typed = input('type name or surname: ')
    result = []
    for contact in contacts:
        if typed in contact['name']:
            result.append(contact)
    if result:
        print(f'hooray! we found {len(result)} results!')
        return result
    else:
        print('looks like you mistyped, try again')
        return search()


def choose_and_act(alist, func):
    choice = input('choose an index: ')
    try:
        person = alist[int(choice)]
        func(person)
    except:
        print('ooops looks like index doesnt exist try again!')
        choose_and_act(alist, func)


def edit(person, add=False):
    if add:
        contacts.append({})
        index = -1
        person = contacts[index]
    name, phone, email = input('enter 1)name 2)phone 3)email, separated by SPACE: ').split(' ')
    person['name'] = name
    person['phone'] = phone
    person['email'] = email


def remove(person):
    contacts.remove(person)


def play():
    print('welcome to address book')
    action = input('what would you like to do? 1=search, 2=add, 3=remove, 4=edit: ')

    if action == '1':
        print('SEARCH activated')
        print(search())
        print('\n==========lets do it again!==========')
        play()

    elif action == '2':
        print('ADD activated')
        edit({}, add=True)
        print(f'hooray! newly added {contacts[-1]}')
        print('\n==========lets do it again!==========')
        play()

    elif action == '3':
        print('REMOVE activated')
        results = search()
        print(results)
        choose_and_act(results, remove)
        print(f'hooray! just removed them!')
        print('\n==========lets do it again!==========')
        play()

    elif action == '4':
        print('EDIT activated')
        results = search()
        print(results)
        choose_and_act(results, edit)
        print('hooray! just edited them!')
        print('\n==========lets do it again!==========')
        play()

    else:
        print('hmm dont recognize input... lets try again')
        play()


if __name__ == '__main__':
    play()
