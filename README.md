# Домашнее задание к занятию "GitLab" - Васин Станислав


### Задание 1

1. Подготовим инфраструктуру для запуска ВМ с GitLab. Создадим ВМ и установим GitLab с помощью Ansible.
2. Войдём в GitLab, создадим пустой публичный проект project-1 для группы root.
3. Подготовим и создадим ВМ для GitLab Runner. Установим Docker с помощью Ansible. GitLab Runner установим вручную через Docker.
4. Внесём изменения в файл config.toml. Запустим контейнер с GitLab Runner. Проверим добавление Runner-а в проект.

![Создание инфраструктуры и ВМ GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img1.png)

![Установка GitLab на ВМ](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img2.png)

![Установка GitLab на ВМ](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img3.png)

![Создание проекта в GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img4.png)

![Создание ВМ GitLab Runner](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img5.png)

![Установка Docker на ВМ](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img6.png)

![Установка GitLab Runner в Docker](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img7.png)

![Изменение конфигурации GitLab Runner](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img8.png)

![Запуск GitLab Runner](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img9.png)

![GitLab Runner в настройках проекта](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img10.png)

![GitLab Runner в настройках проекта](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img11.png)


---

### Задание 2

1. Склонируем репозиторий с исходным кодом на управляющую ВМ. Добавим в качестве удалённого репозитория ВМ с GitLab.
2. Создадим файл .gitlab-ci.yml, в котором опишем запуск теста кода на Go и сборку приложения на Go.
3. Отправим коммит и пуш с новым файлом в репозиторий GitLab. Проверим выполнение сборки.

Файл .gitlab-ci.yml:

```YAML
stages:
  - test
  - build

test_go:
  stage: test
  image: golang:1.17
  script:
   - go test .
  tags:
   - netology
   - hw

build_go_app:
  stage: build
  image: docker:latest
  script:
   - docker build .
  tags:
   - netology
   - hw
```

![Добавление удалённого репозитория](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img12.png)

![Отправка изменений на репозиторий GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img13.png)

![Репозиторий GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img14.png)

![Выполнение сборки в GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img15.png)


---

### Задание 3

1. Изменим CI так, чтобы тесты запускались только при изменении .go файлов и сборка запускалась не дожидаясь окончания тестов.
2. Отправим изменения в репозиторий GitLab и проверим выполнение сборки.
3. Изменим файл main.go и отправим изменения, чтобы проверить работу этапов CI.
4. После работы освободим все ресурсы.

Файл .gitlab-ci.yml:

```YAML
stages:
  - test
  - build

test_go:
  stage: test
  image: golang:1.17
  script:
   - go test .
  tags:
   - netology
   - hw
  rules:
   - changes:
      - "**/*.go"

build_go_app:
  stage: build
  image: docker:latest
  needs: []
  script:
   - docker build .
  tags:
   - netology
   - hw
```

![Отправка изменений на репозиторий GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img16.png)

![Выполнение сборки в GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img17.png)

![Изменение .go файлов](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img18.png)

![Выполнение сборки в GitLab](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img19.png)

![Удаление ресурсов](https://github.com/ucantjugglikeme/netology-7-6-gitlab-hw/blob/main/img/img20.png)
